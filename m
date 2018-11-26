From: Chao Yu <chao@kernel.org>
Subject: Re: Bug in f2fs-tools-1.12.0
Date: Mon, 26 Nov 2018 21:35:22 +0800
Message-ID: <b1c95e28-23ea-cd75-5b9c-310a817eb854@kernel.org>
References: <e8884c8d-9009-cb70-bdf1-73fc38e83abc@GMail.com>
 <c5b93b62-37df-a351-7dc5-e1c0f26b5813@huawei.com>
 <0417cc7e-b1ba-cc3d-e5f6-bbb989000faa@GMail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gRH3S-0002EQ-CN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 13:36:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRH2w-004EEb-6Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 13:36:02 +0000
In-Reply-To: <0417cc7e-b1ba-cc3d-e5f6-bbb989000faa@GMail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Perfect Gentleman <perfect007gentleman@gmail.com>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

SGkgUGVyZmVjdCBHZW50bGVtYW4sCgpPbiAyMDE4LTExLTI2IDE5OjExLCBQZXJmZWN0IEdlbnRs
ZW1hbiB3cm90ZToKPiBIaSBDaGFvCj4gCj4gV2hhdCBwYXRjaCBkbyB5b3UgbWVhbj8KCkkgbWVh
bgoKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2hhby9m
MmZzLXRvb2xzLmdpdC9jb21taXQvP2g9ZGV2LXRlc3QmaWQ9YTYxNjBjM2UyMWY0M2I4OWI0OTgw
MmNjNGE5NTZkMWM0YjY1YWU0NAoKVGhhbmtzLAoKPiAKPiBSZWRhcmRzCj4gCj4gUC5TLiBJdCdz
IHJlcGx5IHRvIGFsbCA6KQo+IAo+IE9uIDExLzI2LzE4IDU6NTIgUE0sIENoYW8gWXUgd3JvdGU6
Cj4+IEhpIFBlcmZlY3QgR2VudGxlbWFuLAo+Pgo+PiBUaGFua3MgZm9yIHRoZSByZXBvcnQuCj4+
Cj4+IE9uIDIwMTgvMTEvMjUgMTM6MjQsIFBlcmZlY3QgR2VudGxlbWFuIHdyb3RlOgo+Pj4gSGkg
ZjJmcy10ZWFtLAo+Pj4KPj4+IHRoZXJlIGlzIGJ1ZzogZnNjay5mMmZzIGNhbm5vdCBjaGVjayBy
ZWFkLW9ubHkgZmlsZXN5c3RlbS4gQnV0IDEuMTEuMAo+Pj4gY2FuIGRvIHRoYXQuCj4+Pgo+Pj4g
ZnNja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHxJbmZvOiBGaXggdGhlIHJlcG9ydGVkIGNv
cnJ1cHRpb24uCj4+PiBmc2NrwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfEluZm86IE1vdW50
ZWQgZGV2aWNlIQo+Pj4gZnNja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHxJbmZvOiBDaGVj
ayBGUyBvbmx5IGR1ZSB0byBSTwo+Pj4gZnNja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHxF
cnJvcjogRmFpbGVkIHRvIG9wZW4gdGhlIGRldmljZSEKPj4gSSBndWVzcyB0aGlzIGlzIGR1ZSB0
byBiZWxvdyBjb21taXQsIHdoaWNoIHN0b3Agb3BlbmluZyBkZXZpY2UgaW4KPj4gZjJmcy10b29s
cyBpZiB0aGUgZGV2aWNlIGhhcyBhbHJlYWR5IGJlZW4gb3BlbmVkIGJ5IG90aGVyIG9uZSwgbGlr
ZSBtb3VudC4KPj4KPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvamFlZ2V1ay9mMmZzLXRvb2xzLmdpdC9jb21taXQvP2g9ZGV2LXRlc3QmaWQ9ZWI5ZDgw
MzdlZDNiMzdhNjQ3ZDUxNDQ3MGYxYTFkZjkxZGFlZGI2NAo+Pgo+Pgo+PiBJIHRyaWVkIGUyZnNw
cm9ncywgdy9vIC1mIG9wdGlvbiwgdGhlIHJlc3VsdCBpcyB0aGUgc2FtZToKPj4KPj4gZnNjayAx
LjQ0LjQgKDE4LUF1Zy0yMDE4KQo+PiBlMmZzY2sgMS40NC40ICgxOC1BdWctMjAxOCkKPj4gL2Rl
di96cmFtMCBpcyBtb3VudGVkLgo+PiBlMmZzY2s6IENhbm5vdCBjb250aW51ZSwgYWJvcnRpbmcu
Cj4+Cj4+IEJ1dCBzdGlsbCB3ZSBjYW4gdHJpZ2dlciBmb3JjZWQgZnNjay5leHQ0IGJ5IHVzaW5n
IC1mIG9wdGlvbi4KPj4KPj4gQ291bGQgeW91IGhhdmUgYSB0cnkgd2l0aCBmb2xsb3dpbmcgcGF0
Y2g/Cj4+Cj4+IFtQQVRDSF0gZnNjay5mMmZzOiBhbGxvdyB0byBmc2NrIHJlYWRvbmx5IGltYWdl
IHcvIC1mIG9wdGlvbgo+Pgo+PiBUaGFua3MsCj4+Cj4+PiBmc2NrwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAqIEZpbGVzeXN0ZW1zIGNvdWxkbid0IGJlIGZpeGVkCj4+PiDCoCDCoFsgISEg
XQo+Pj4gZnNja8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgKiBFUlJPUjogZnNjayBmYWls
ZWQgdG8gc3RhcnQKPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQWxleAo+Pj4KPj4+Cj4+Pgo+Pj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IExpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAo+Pj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bGludXgtZjJmcy1kZXZlbAo+Pj4KPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
