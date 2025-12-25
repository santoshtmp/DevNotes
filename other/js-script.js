
(function () {

    function downloadCSV(csv, filename) {
        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', filename);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    function escapeCSV(value) {
        return `"${(value || '').replace(/"/g, '""')}"`;
    }

    const data = [['Plugin', 'Description', 'Status', 'Version', 'Plugin URL']];
    document.querySelectorAll('#the-list > tr').forEach(tr => {
        const plugin = tr.querySelector('.plugin-title strong')?.innerText.trim() || '';
        const description = tr.querySelector('.plugin-description p')?.innerText.trim() || '';

        const isActive = tr.classList.contains('active');
        const status = isActive ? 'Active' : 'Deactivate';

        const versionText = tr.querySelector('.plugin-version-author-uri')?.innerText || '';
        const versionMatch = versionText.match(/Version\s([\d.]+)/i);
        const version = versionMatch ? versionMatch[1] : '';

        const pluginURL = tr.querySelector('.plugin-version-author-uri a[href*="plugin-information"]')?.href || '';

        // const autoUpdate = tr.querySelector('.column-auto-updates .label')?.innerText.trim() || '';
        data.push([plugin, description, status, version, pluginURL].map(escapeCSV));
    });

    const data_content = data.map(row => row.join(',')).join('\n');

    downloadCSV(data_content, 'exported-data.csv');

})();


/**
 * --------------------------------------------------------------
 */



// Helper: escape CSV-style values (not needed for Excel but left if useful elsewhere)
function escapeCSV(value) {
    if (typeof value !== 'string') return value;
    return value.replace(/"/g, '""');
}

// collect plugin data from the page
function collectPluginData() {
    const data = [['Plugin', 'Description', 'Status', 'Version', 'Plugin URL']];

    document.querySelectorAll('#the-list > tr').forEach(tr => {
        const plugin = tr.querySelector('.plugin-title strong')?.innerText.trim() || '';
        const description = tr.querySelector('.plugin-description p')?.innerText.trim() || '';
        const status = tr.classList.contains('active') ? 'Active' : 'Deactivate';
        const versionText = tr.querySelector('.plugin-version-author-uri')?.innerText || '';
        const versionMatch = versionText.match(/Version\s([\d.]+)/i);
        const version = versionMatch ? versionMatch[1] : '';
        let pluginURL = '';
        const pluginLink = tr.querySelector('.plugin-version-author-uri a[href*="plugin-information"]')?.href || '';
        if (pluginLink) {
            try {
                const url = new URL(pluginLink);
                const pluginSlug = url.searchParams.get('plugin') || '';
                if (pluginSlug) {
                    pluginURL = `https://wordpress.org/plugins/${pluginSlug}`;
                }
            } catch (err) {
                // In case URL is malformed
                pluginURL = '';
            }
        }
        // Only push if at least plugin name exists
        if (plugin) {
            data.push([
                escapeCSV(plugin),
                escapeCSV(description),
                status,
                version,
                pluginURL
            ]);
        }

    });

    return data;
}

// Download data as Excel
async function downloadPluginDataAsExcel(data, filename = 'data') {
    const script = document.createElement('script');
    script.src = 'https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js';
    document.head.appendChild(script);
    await new Promise(resolve => script.onload = resolve);

    const ws = XLSX.utils.aoa_to_sheet(data);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, filename);
    XLSX.writeFile(wb, filename + '.xlsx');
}

// usage:
const pluginData = collectPluginData();
downloadPluginDataAsExcel(pluginData);

