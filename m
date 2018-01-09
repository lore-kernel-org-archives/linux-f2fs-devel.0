From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: [PATCH] f2fs: move set_cold_files after adding new
 node page in f2fs_create
Date: Tue, 09 Jan 2018 11:05:15 +0000
Message-ID: <20180109110515epcms1p46c7a239808f0875115954673c037fc89@epcms1p4>
References: <affff153-1dc7-32f8-0285-2db5c11cf050@huawei.com>
 <1515457415-20645-1-git-send-email-daeho.jeong@samsung.com>
 <CGME20180109002317epcas2p1ecf6e4fbe5f80519cb4cede32a057e6e@epcms1p4>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <daeho.jeong@samsung.com>) id 1eYrif-0006q0-LJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 11:05:25 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYrid-0004pX-0I
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 11:05:25 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20180109110515epoutp047d10f1e9ee24b3f9d3181b7570f0a8e5~IH4F-cFhP3012630126epoutp04b
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Jan 2018 11:05:15 +0000 (GMT)
In-Reply-To: <affff153-1dc7-32f8-0285-2db5c11cf050@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

SGkgQ2hhbywKwqANCg0KPiA+wqBOb3cswqB3ZcKgc2V0wqBmbGFnc8Kgb2bCoGHCoG5ld2x5wqBj
cmVhdGVkwqBpbm9kZcKgdXNpbmfCoHNldF9jb2xkX2ZpbGVzKCnCoGluDQo+ID7CoGFkdmFuY2XC
oG9mwqBjcmVhdGluZ8KgYcKgbmV3wqBub2RlwqBwYWdlLsKgQnnCoHRoaXMswqBzb21lwqBpbm9k
ZXPCoHdob3NlwqBub2RlDQo+wqA+IHBhZ2XCoGlzwqBub3TCoGNyZWF0ZWTCoHlldMKgY2FuwqBi
ZcKgbGlua2VkwqBpbnRvwqB0aGXCoGdsb2JhbMKgZGlydHnCoGxpc3QuDQo+wqA+DQo+wqA+IElm
wqB0aGXCoGNoZWNrcG9pbnTCoGlzwqBleGVjdXRlZMKgYXTCoHRoaXPCoG1vbWVudCzCoHRoZcKg
aW5vZGXCoHdpbGzCoGJlwqB3cml0dGVuDQo+wqA+IGJhY2vCoGJ5wqB3cml0ZWJhY2tfc2luZ2xl
X2lub2RlKCnCoGFuZMKgZmluYWxsecKgdXBkYXRlX2lub2RlX3BhZ2UoKcKgd2lsbA0KPsKgPiBm
YWlswqB0b8KgZGV0YWNowqB0aGXCoGlub2RlwqBmcm9twqB0aGXCoGdsb2JhbMKgZGlydHnCoGxp
c3TCoGJlY2F1c2XCoHRoZcKgaW5vZGUNCj7CoD4gZG9lc24ndMKgaGF2ZcKgYcKgbm9kZcKgcGFn
ZS4NCj7CoD4NCj7CoD4gVGhlwqBwcm9ibGVtwqBpc8KgdGhhdMKgdGhlwqBpbm9kZSdzwqBzdGF0
ZcKgaW7CoFZGU8KgbGF5ZXLCoHdpbGzCoGJlY29tZcKgY2xlYW4NCj7CoD4gYWZ0ZXLCoGV4ZWN1
dGlvbsKgb2bCoHdyaXRlYmFja19zaW5nbGVfaW5vZGUoKcKgYW5kwqBpdCdzwqBzdGlsbMKgbGlu
a2VkwqBpbg0KPsKgPiB0aGXCoGdsb2JhbMKgZGlydHnCoGxpc3TCoG9mwqBmMmZzwqBhbmTCoHRo
aXPCoHdpbGzCoGNhdXNlwqBhwqBrZXJuZWzCoHBhbmljLg0KwqANCj4gQmVmb3JlwqBzZXRfY29s
ZF9maWxlcyzCoEluwqBmMmZzX25ld19pbm9kZSzCoHdlwqB3aWxswqBhbHNvwqBkaXJ0ecKgaW5v
ZGUswqBzb8KgaWYNCj4gd2XCoG9ubHnCoHJlbG9jYXRlwqBjb2RlwqBmaWxlwqBpbml0aWFsaXph
dGlvbizCoHdvdWxkwqB3ZcKgc3VmZmVywqB0aGXCoHNhbWXCoGlzc3VlDQo+IGR1ZcKgdG/CoGJl
bG93wqByZWFzb24/wqBJZsKgc28swqBpbnN0ZWFkLMKgaG93wqBhYm91dMKgY2hlY2vCoEZJX05F
V19JTk9ERcKgZmxhZw0KPiBkdXJpbmfCoGdsb2JhbMKgZGlydHnCoGxpc3TCoGZsdXNoaW5nwqB0
b8KgZGVjaWRlwqB3aGV0aGVywqB3ZcKgc2hvdWxkwqBmbHVzaMKgdGhhdA0KPiBpbm9kZT/CoEhv
d8KgZG/CoHlvdcKgdGhpbms/DQrCoA0KPiBUaGFua3MsDQoNCk9vcHMsIEkgbWlzc2VkIGYyZnNf
c2V0X2VuY3J5cHRlZF9pbm9kZSgpIGluIGYyZnNfbmV3X2lub2RlKCksIGJlY2F1c2Ugd2UNCnR1
cm5lZCBvZmYgdGhlIGZpbGVzeXN0ZW0gZW5jcnlwdGlvbiBmZWF0dXJlLg0KDQpJZiB3ZSBza2lw
IHRoZSBpbm9kZSB3aGljaCBpcyBzZXQgd2l0aCBGSV9ORVdfSU5PREUgZmxhZyBkdXJpbmcgZ2xv
YmFsDQpkaXJ0eSBsaXN0IGZsdXNoaW5nIGluIGJsb2NrX29wZXJhdGlvbnMoKSwgd2UgbmVlZCB0
byBpdGVyYXRlIGFnYWluIGFuZA0KYWdhaW4gaW4gYmxvY2tfb3BlcmF0aW9ucygpIHRpbGwgdGhl
IG5ldyBpbm9kZSBpcyBhZGRlZCB0byBpdHMgcGFyZW50IGlub2RlDQphbmQgRklfTkVXX0lOT0RF
IGZsYWcgaXMgY2xlYXJlZC4NCg0KSG93IGFib3V0IHRoYXQgd2UgZG9uJ3QgZG8gYW55dGhpbmcg
Zm9yIHRoZSBpbm9kZSBoYXZpbmcgRklfTkVXX0lOT0RFIGZsYWcNCmluIGYyZnNfbWFya19pbm9k
ZV9kaXJ0eV9zeW5jKCkgYW5kIGludm9rZSBmMmZzX21hcmtfaW5vZGVfZGlydHlfc3luYygpDQpy
aWdodCBhZnRlciB3ZSBjbGVhciBGSV9ORVdfSU5PREUgZmxhZyBpbiB1cGRhdGVfcGFyZW50X21l
dGFkYXRhKCk/DQoNClRoYW5rcywNCg0KDQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDaGVjayBv
dXQgdGhlIHZpYnJhbnQgdGVjaCBjb21tdW5pdHkgb24gb25lIG9mIHRoZSB3b3JsZCdzIG1vc3QK
ZW5nYWdpbmcgdGVjaCBzaXRlcywgU2xhc2hkb3Qub3JnISBodHRwOi8vc2RtLmxpbmsvc2xhc2hk
b3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
ZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgt
ZjJmcy1kZXZlbAo=
