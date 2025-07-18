package models

type CpuInfo struct {
	Procesor  string `json:"processor"`
	VendorId  string `json:"vendor_id"`
	ModelName string `json:"model name"`
	CpuMHz    string `json:"cpu MHz"`
	CacheSize string `json:"cache size"`
	CpuCores  string `json:"cpu cores"`
	CoreId    string `json:"core id"`
}

type MemRamInfo struct {
	MemTotal     string `json:"MemTotal"`
	MemFree      string `json:"MemFree"`
	MemAvailable string `json:"MemAvailable"`
	SwapTotal    string `json:"SwapTotal"`
	SwapFree     string `json:"SwapFree"`
	Cached       string `json:"Cached"`
	SwapCached   string `json:"SwapCached"`
}
