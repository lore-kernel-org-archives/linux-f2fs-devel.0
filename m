Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9CAC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Oct 2022 10:26:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olSl6-0006BK-PT;
	Thu, 20 Oct 2022 10:26:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1olSko-00069L-Mz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 10:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PEYKqmmYEYaAYIImt9xIperHqEZcJMTkoRMtpCOSQCE=; b=Wil3NVko2hEV9yomIdbircI6x5
 lvltLg5I4mz9wzmscFt8isMl2Z8eqHjMYvBdr+I1CUep6YwMWzcziOMDlCffBNPeYhHENffNgSS4e
 9PO/pmAQSmRE+qkSSfkBe1vKYjtKyeyQ+hb+ipw+py2xiIGQkJxLQUdUkJJv6bzwAMsA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PEYKqmmYEYaAYIImt9xIperHqEZcJMTkoRMtpCOSQCE=; b=Nl3/NYPUN0Q4PfScaPwnoVZBIy
 d9ciAPSURFIeSoidY6zkWmmQAoEcYTvavxWSM6nC08qY3Lv+iWOO4Jc/4FqC84NZ++nQ5SxPJ69QM
 hzHC3EYZrVJTGUf6FVOsAHQUCy59ZbS7E4OCPOtHP1lSCxbeGth+GSSEksg8W7eTQim0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olSkl-00AmYc-AX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 10:26:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 54D9C61A8E;
 Thu, 20 Oct 2022 10:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A15C433B5;
 Thu, 20 Oct 2022 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666261571;
 bh=f+0yPKgGnSqCnJlJw84xS5/DPdIIoIUMMcramBkoJ94=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZWCeDfKvFQWoyNZfDzoGwFx4FMVmIblYaTmZ2fDULFNFcFzj4kTZFsb8UxZzsN+KC
 gt5b/SScb+2a67EsJi9vhWwWIVeqk2O5dLrY4uy6vqIWZJBzIsklSvLjIPrv/WkScV
 rX2Ep0ndgzhCMEZ9p+e0SOOjjaYARBkKFV2TM6AV9JHqTeNHDPFjzNE9hcz4mzVJvf
 4OMQnCOSJ8m1vvDSFu5uPgCSyudGeTwNW6NtCF2NIPIBFSuR6tQ9PdIj10z9BbYUnx
 ezLHZOODQllmbQ3RWIvpC57SBBYhC/9zvwI0CyFmy5D0i0RFTBBPlxzISqKLppOk69
 YZcSiKAcNk4qw==
Message-ID: <7d8de936-fa3c-3bd8-2415-e97c8a868666@kernel.org>
Date: Thu, 20 Oct 2022 18:26:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org,
 mhiramat@kernel.org
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
 <35c29f27-96c6-6d74-1efb-1588cbf430a2@kernel.org>
 <8cb1ce88-2e49-745a-dd40-29a084ce285b@quicinc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <8cb1ce88-2e49-745a-dd40-29a084ce285b@quicinc.com>
X-Headers-End: 1olSkl-00AmYc-AX
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the assign logic of iocb
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMi8xMC8yMCAxNzoyNywgTXVrZXNoIE9qaGEgd3JvdGU6Cj4gSGksCj4gCj4gT24gMTAv
MjAvMjAyMiAyOjMxIFBNLCBDaGFvIFl1IHdyb3RlOgo+PiBPbiAyMDIyLzEwLzIwIDA6MTcsIE11
a2VzaCBPamhhIHdyb3RlOgo+Pj4gY29tbWl0IDE4YWU4ZDEyOTkxYiAoImYyZnM6IHNob3cgbW9y
ZSBESU8gaW5mb3JtYXRpb24gaW4gdHJhY2Vwb2ludCIpCj4+PiBpbnRyb2R1Y2VzIGlvY2IgZmll
bGQgaW4gJ2YyZnNfZGlyZWN0X0lPX2VudGVyJyB0cmFjZSBldmVudAo+Pj4gQW5kIGl0IG9ubHkg
YXNzaWducyB0aGUgcG9pbnRlciBhbmQgbGF0ZXIgaXQgYWNjZXNzZXMgaXRzIGZpZWxkCj4+PiBp
biB0cmFjZSBwcmludCBsb2cuCj4+Pgo+Pj4gRml4IGl0IGJ5IGNvcnJlY3RpbmcgZGF0YSB0eXBl
IGFuZCBtZW1jcHkgdGhlIGNvbnRlbnQgb2YgaW9jYi4KPj4KPj4gU28gdGhlIGltcGxlbWVudGF0
aW9uIGJlbG93IGlzIHdyb25nLCByaWdodD8gc2luY2UgaXQganVzdCBhc3NpZ24gX19lbnRyeS0+
bmFtZQo+PiB3aXRoIGRlbnRyeS0+ZF9uYW1lLm5hbWUgcmF0aGVyIHRoYW4gY29weWlueSBlbnRp
cmVseSwgc28gdGhhdCwgZHVyaW5nIHByaW50aW5nCj4gCj4gSSB0aGluaywgeWVzLgo+IAo+IEFi
b3V0IHRoZSBwYXRjaCwgd2Ugd2VyZSBnZXR0aW5nIGVycm9yIGFzIGJlbG93IG9uIGRvaW5nCgpU
aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gOikKCldoYXQgZG8geW91IHRoaW5rIG9mIGFkZGlu
ZyBiZWxvdyBpbmZvIGludG8gY29tbWl0IG1lc3NhZ2U/IGFuZCBmaXhpbmcgYWxsCnNpbWlsYXIg
aXNzdWVzIG9mIGluY2x1ZGUvdHJhY2UvZXZlbnRzL2YyZnMuaCBpbiBvbmUgcGF0Y2g/CgpUaGFu
a3MsCgo+IAo+IGVjaG8gNTEyMDAgPiAvZC90cmFjaW5nL2J1ZmZlcl9zaXplX2tiCj4gZWNobyAx
ID4gL2QvdHJhY2luZy9ldmVudHMvZjJmcy9mMmZzX2RpcmVjdF9JT19lbnRlci9lbmFibGUKPiBl
Y2hvIDEgPiAvZC90cmFjaW5nL3RyYWNpbmdfb24KPiBjYXQgL2QvdHJhY2luZy90cmFjZV9waXBl
ID4gZnRyYWNlLmxvZwo+IAo+IFJ1biBzb21ldGhpbmcgd2hpY2ggZXhlcmNpc2UgdGhpcyBwYXRo
Lgo+IAo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwg
YWRkcmVzcyBmZmZmZmZjMDRjZWYzZDMwCj4gTWVtIGFib3J0IGluZm86Cj4gRVNSID0gMHg5NjAw
MDAwNwo+IEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cwo+IAo+ICDC
oHBjIDogdHJhY2VfcmF3X291dHB1dF9mMmZzX2RpcmVjdF9JT19lbnRlcisweDU0LzB4YTQKPiAg
wqBsciA6IHRyYWNlX3Jhd19vdXRwdXRfZjJmc19kaXJlY3RfSU9fZW50ZXIrMHgyYy8weGE0Cj4g
IMKgc3AgOiBmZmZmZmZjMDQ0M2NiYmQwCj4gIMKgeDI5OiBmZmZmZmZjMDQ0M2NiYmYwIHgyODog
ZmZmZmZmODkzNWIxMjBkMCB4Mjc6IGZmZmZmZjg5MzViMTIxMDgKPiAgwqB4MjY6IGZmZmZmZjg5
MzViMTIwZjAgeDI1OiBmZmZmZmY4OTM1YjEyMTAwIHgyNDogZmZmZmZmODkzNWIxMTBjMAo+ICDC
oHgyMzogZmZmZmZmODkzNWIxMDAwMCB4MjI6IGZmZmZmZjg4ODU5YTkzNmMgeDIxOiBmZmZmZmY4
ODg1OWE5MzZjCj4gIMKgeDIwOiBmZmZmZmY4OTM1YjExMGMwIHgxOTogZmZmZmZmODkzNWIxMDAw
MCB4MTg6IGZmZmZmZmMwM2IxOTUwNjAKPiAgwqB4MTc6IGZmZmZmZjg5MzViMTFlNzYgeDE2OiAw
MDAwMDAwMDAwMDAwMGNjIHgxNTogZmZmZmZmZWY4NTVjNGYyYwo+ICDCoHgxNDogMDAwMDAwMDAw
MDAwMDAwMSB4MTM6IDAwMDAwMDAwMDAwMDAwNGUgeDEyOiBmZmZmMDAwMGZmZmZmZjAwCj4gIMKg
eDExOiBmZmZmZmZlZjg2YzM1MGQwIHgxMDogMDAwMDAwMDAwMDAwMTBjMCB4OSA6IDAwMDAwMDAw
MGZlMDAwMmMKPiAgwqB4OCA6IGZmZmZmZmMwNGNlZjNkMjggeDcgOiA3ZjdmN2Y3ZjdmN2Y3Zjdm
IHg2IDogMDAwMDAwMDAwMjAwMDAwMAo+ICDCoHg1IDogZmZmZmZmODkzNWIxMWU5YSB4NCA6IDAw
MDAwMDAwMDAwMDYyNTAgeDMgOiBmZmZmMGEwMGZmZmZmZjA0Cj4gIMKgeDIgOiAwMDAwMDAwMDAw
MDAwMDAyIHgxIDogZmZmZmZmZWY4NmEwYTMxZiB4MCA6IGZmZmZmZjg5MzViMTAwMDAKPiAgwqBD
YWxsIHRyYWNlOgo+ICDCoCB0cmFjZV9yYXdfb3V0cHV0X2YyZnNfZGlyZWN0X0lPX2VudGVyKzB4
NTQvMHhhNAo+ICDCoCBwcmludF90cmFjZV9mbXQrMHg5Yy8weDEzOAo+ICDCoCBwcmludF90cmFj
ZV9saW5lKzB4MTU0LzB4MjU0Cj4gIMKgIHRyYWNpbmdfcmVhZF9waXBlKzB4MjFjLzB4MzgwCj4g
IMKgIHZmc19yZWFkKzB4MTA4LzB4M2FjCj4gIMKgIGtzeXNfcmVhZCsweDdjLzB4ZWMKPiAgwqAg
X19hcm02NF9zeXNfcmVhZCsweDIwLzB4MzAKPiAgwqAgaW52b2tlX3N5c2NhbGwrMHg2MC8weDE1
MAo+ICDCoCBlbDBfc3ZjX2NvbW1vbi5sbHZtLjEyMzc5NDM4MTYwOTE3NTUwNjcrMHhiOC8weGY4
Cj4gIMKgIGRvX2VsMF9zdmMrMHgyOC8weGEwCj4gCj4gLU11a2VzaAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
