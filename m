Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA700F30946
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncGyKTgRMFGdPAomLOB9CIdR0d+GXY3SoesNN76zkp0=; b=TiN1VpW911jgPfnA5seJwrFJOO
	mgUasvUA3dGEqtW7X91hCvT3y9jAXGa4eIzzo0rU0Iu+46zf86n7DjAaw+Ict61LaNtv1TIX6U95M
	WNHZECsvCXEbh7qYh8VWAwauGSTZWq1kp2/VNF8Xz0JETnUSuWn56D23HzPisK7YK0QE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vy6zO-00007m-PA;
	Thu, 05 Mar 2026 11:35:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1vy6zB-00007L-Ii
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 11:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/ft10Nc/n+r6Jug1SZlVHAvFg3qwatV9hqCT6rUnK8=; b=fICdHx8wwi4R0dwQMuJkVLazg3
 QppbJvKL2bc5sWQkVl359o91ZN6J33v0KsvgBmgXM5PpLBYG+KKrw5Ot7H+3NrAZEFbpNILM6rIm+
 N4iEq9ceP7T/7qT3N7vV6aJdPTkR/zPJkiVe9zXRFSbHXVYKs0n+KLHhn9O5UTqpeeBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G/ft10Nc/n+r6Jug1SZlVHAvFg3qwatV9hqCT6rUnK8=; b=X39+LcvAeVyx5P8Q7ZHXfroNsj
 9xGbY4Cu2kh3v/DlPoKyTfKaHz4Oe/f49psqjRjLHqvw7GhwK1PW3fDPNaRRXIgslCDqGPD1p6L5e
 BkN6LScY4GMzYs6h7h8O578NCMt213Tu7FkC8AeWvh3V3I5biiicf+EdP32P5wxUbIf4=;
Received: from mail3-163.sinamail.sina.com.cn ([202.108.3.163])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vy6zA-0003kf-Em for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 11:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1772710520; bh=G/ft10Nc/n+r6Jug1SZlVHAvFg3qwatV9hqCT6rUnK8=;
 h=Message-ID:Date:Subject:From;
 b=DGAq8NVjOWGZFBxLRGbhZqewuaSDln3UEZ+VwbYU34dV3bQx+NTwnEyMl+jd0V7rb
 OqsI2U00GBgc7qU4QfZUyMSYR/KeuXULkTV1Iz60MTRH90a2LWnHOFDq1j4H7oG08r
 p78mcLTnCBPks4+pTCOoBHw7QWE0c3J36P/hvgu0=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.34) with ESMTP
 id 69A96A6900001030; Thu, 5 Mar 2026 19:35:07 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 6070676291988
X-SMAIL-UIID: 6E1E767D0B04435393BD6560F2DCD02A-20260305-193507-1
Message-ID: <f3d9edda-7361-4b3b-a657-76e34a32ce07@sina.com>
Date: Thu, 5 Mar 2026 19:35:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260203134027.3942948-3-monty_pavel@sina.com>
 <a649de9a-619b-47a6-81bf-5b0feafb7325@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <a649de9a-619b-47a6-81bf-5b0feafb7325@kernel.org>
X-Headers-End: 1vy6zA-0003kf-Em
Subject: Re: [f2fs-dev] [PATCH] f2fs_io: add flags parameter to fiemap
 subcommand
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMy80LzI2IDE3OjQwLCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOgo+IE9u
IDIwMjYvMi8zIDIxOjQwLCBZb25ncGVuZyBZYW5nIHdyb3RlOgo+PiBGcm9tOiBZb25ncGVuZyBZ
YW5nIDx5YW5neW9uZ3BlbmdAeGlhb21pLmNvbT4KPj4KPj4gQWRkIGEgZmxhZ3MgcGFyYW1ldGVy
IHRvIHRoZSBmaWVtYXAgc3ViY29tbWFuZCwgYWxsb3dpbmcgdGhlCj4+IHNwZWNpZmljYXRpb24g
b2Ygd2hldGhlciB0byByZXRyaWV2ZSBmaWxlIG1hcHBpbmdzIGFmdGVyIHdyaXRpbmcgdG8gdGhl
Cj4+IGZpbGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFlvbmdwZW5nIFlhbmcgPHlhbmd5b25ncGVu
Z0B4aWFvbWkuY29tPgo+PiAtLS0KPj4gwqAgdG9vbHMvZjJmc19pby9mMmZzX2lvLmMgfCAxNiAr
KysrKysrKysrKy0tLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvZjJmc19pby9mMmZzX2lvLmMg
Yi90b29scy9mMmZzX2lvL2YyZnNfaW8uYwo+PiBpbmRleCA0NDI5ZTBiLi4zYjE5NzI0IDEwMDY0
NAo+PiAtLS0gYS90b29scy9mMmZzX2lvL2YyZnNfaW8uYwo+PiArKysgYi90b29scy9mMmZzX2lv
L2YyZnNfaW8uYwo+PiBAQCAtMTM0MSw4ICsxMzQxLDExIEBAIHN0YXRpYyB2b2lkIGRvX3JhbmRy
ZWFkKGludCBhcmdjLCBjaGFyICoqYXJndiwKPj4gY29uc3Qgc3RydWN0IGNtZF9kZXNjICpjbWQp
Cj4+IMKgIH0KPj4gwqAgwqAgI2RlZmluZSBmaWVtYXBfZGVzYyAiZ2V0IGJsb2NrIGFkZHJlc3Mg
aW4gZmlsZSIKPj4gLSNkZWZpbmUgZmllbWFwX2hlbHDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4+IC0iZjJmc19pbyBmaWVtYXAgW29mZnNldCBpbiA0a2JdIFtjb3Vu
dCBpbiA0a2JdIFtmaWxlX3BhdGhdXG5cbiJcCj4+ICsjZGVmaW5lIGZpZW1hcF9oZWxwwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gKyJm
MmZzX2lvIGZpZW1hcCBbb2Zmc2V0IGluIDRrYl0gW2NvdW50IGluIDRrYl0gW2ZsYWdzXQo+PiBb
ZmlsZV9wYXRoXVxuXG4iwqDCoMKgIFwKPj4gKyJmbGFncyBjYW4gYmUgdGhlIGZvbGxvd2luZyB2
YWx1ZXM6XG4iwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArIjA6
IE5vIGV4dHJhIGFjdGlvbnNcbiLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+PiArIjE6IFN5bmMgZmlsZSBkYXRhIGJlZm9yZSBtYXBcbiLC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgIMKgICNpZiBkZWZp
bmVkKEhBVkVfTElOVVhfRklFTUFQX0gpICYmIGRlZmluZWQoSEFWRV9MSU5VWF9GU19IKQo+PiDC
oCBzdGF0aWMgdm9pZCBkb19maWVtYXAoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBzdHJ1
Y3QgY21kX2Rlc2MKPj4gKmNtZCkKPj4gQEAgLTEzNTAsMTAgKzEzNTMsMTAgQEAgc3RhdGljIHZv
aWQgZG9fZmllbWFwKGludCBhcmdjLCBjaGFyICoqYXJndiwKPj4gY29uc3Qgc3RydWN0IGNtZF9k
ZXNjICpjbWQpCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGk7Cj4+IMKgwqDCoMKgwqAgaW50
IGZkLCBleHRlbnRzX21lbV9zaXplOwo+PiDCoMKgwqDCoMKgIHU2NCBzdGFydCwgbGVuZ3RoOwo+
PiAtwqDCoMKgIHUzMiBtYXBwZWRfZXh0ZW50czsKPj4gK8KgwqDCoCB1MzIgbWFwcGVkX2V4dGVu
dHMsIGZsYWdzOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBmaWVtYXAgKmZtID0geG1hbGxvYyhzaXpl
b2Yoc3RydWN0IGZpZW1hcCkpOwo+PiDCoCAtwqDCoMKgIGlmIChhcmdjICE9IDQpIHsKPj4gK8Kg
wqDCoCBpZiAoYXJnYyAhPSA1KSB7Cj4gCj4gQ2FuIHdlIGFjY2VwdCBuZXcgZmxhZ3MgYXMgb3B0
aW9uYWw/IG90aGVyd2lzZSwgaXQgd2lsbCBicmVhayB1c2Vyc3BhY2UKPiB1c2FnZSBvbgo+IHRo
aXMgZjJmc19pbyBmaWVtYXAuCgpZZXMsIHRoaXMgbWFrZXMgbW9yZSBzZW5zZS4gSSdsbCBmaXgg
dGhpcyBpbiB2MyBwYXRjaC4KClRoYW5rcwpZb25ncGVuZywKCj4gCj4gVGhhbmtzLAo+IAo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZnB1dHMoIkV4Y2VzcyBhcmd1bWVudHNcblxuIiwgc3RkZXJyKTsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZwdXRzKGNtZC0+Y21kX2hlbHAsIHN0ZGVycik7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBleGl0KDEpOwo+PiBAQCAtMTM2MiwxMCArMTM2NSwxMiBAQCBzdGF0
aWMgdm9pZCBkb19maWVtYXAoaW50IGFyZ2MsIGNoYXIgKiphcmd2LAo+PiBjb25zdCBzdHJ1Y3Qg
Y21kX2Rlc2MgKmNtZCkKPj4gwqDCoMKgwqDCoCBtZW1zZXQoZm0sIDAsIHNpemVvZihzdHJ1Y3Qg
ZmllbWFwKSk7Cj4+IMKgwqDCoMKgwqAgc3RhcnQgPSAodTY0KWF0b2koYXJndlsxXSkgKiBGMkZT
X0RFRkFVTFRfQkxLU0laRTsKPj4gwqDCoMKgwqDCoCBsZW5ndGggPSAodTY0KWF0b2koYXJndlsy
XSkgKiBGMkZTX0RFRkFVTFRfQkxLU0laRTsKPj4gK8KgwqDCoCBmbGFncyA9ICh1MzIpYXRvaShh
cmd2WzNdKTsKPj4gwqDCoMKgwqDCoCBmbS0+Zm1fc3RhcnQgPSBzdGFydDsKPj4gwqDCoMKgwqDC
oCBmbS0+Zm1fbGVuZ3RoID0gbGVuZ3RoOwo+PiArwqDCoMKgIGZtLT5mbV9mbGFncyA9IGZsYWdz
Owo+PiDCoCAtwqDCoMKgIGZkID0geG9wZW4oYXJndlszXSwgT19SRE9OTFkgfCBPX0xBUkdFRklM
RSwgMCk7Cj4+ICvCoMKgwqAgZmQgPSB4b3Blbihhcmd2WzRdLCBPX1JET05MWSB8IE9fTEFSR0VG
SUxFLCAwKTsKPj4gwqAgwqDCoMKgwqDCoCBwcmludGYoIkZpZW1hcDogb2Zmc2V0ID0gJSJQUkl1
NjQiIGxlbiA9ICUiUFJJdTY0IlxuIiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdGFydCAvIEYyRlNfREVGQVVMVF9CTEtTSVpFLAo+PiBAQCAtMTM4MSw2ICsxMzg2LDcg
QEAgc3RhdGljIHZvaWQgZG9fZmllbWFwKGludCBhcmdjLCBjaGFyICoqYXJndiwKPj4gY29uc3Qg
c3RydWN0IGNtZF9kZXNjICpjbWQpCj4+IMKgwqDCoMKgwqAgbWVtc2V0KGZtLCAwLCBzaXplb2Yo
c3RydWN0IGZpZW1hcCkgKyBleHRlbnRzX21lbV9zaXplKTsKPj4gwqDCoMKgwqDCoCBmbS0+Zm1f
c3RhcnQgPSBzdGFydDsKPj4gwqDCoMKgwqDCoCBmbS0+Zm1fbGVuZ3RoID0gbGVuZ3RoOwo+PiAr
wqDCoMKgIGZtLT5mbV9mbGFncyA9IGZsYWdzOwo+PiDCoMKgwqDCoMKgIGZtLT5mbV9leHRlbnRf
Y291bnQgPSBtYXBwZWRfZXh0ZW50czsKPj4gwqAgwqDCoMKgwqDCoCBpZiAoaW9jdGwoZmQsIEZT
X0lPQ19GSUVNQVAsIGZtKSA8IDApCj4gCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+
IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
