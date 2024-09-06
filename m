Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A353CE7AFD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:08:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1smVsn-0004Ez-A5;
	Fri, 06 Sep 2024 10:08:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1smVsm-0004Eq-6y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Sep 2024 10:08:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GhIYm7qihXq2EcYauQ7XvvUF1wbNHwrAAQlOQMYMVPI=; b=kPFHHF3NbukBrkh+DHZz61fovr
 jS34Y4/pGSjD+BUWlYaEMFBtgVRlxkNr2V8Xv1ewXbyHMqSknGk/FMLIdFS/CM9Q5im8L0+AjkvIg
 YvkMzWKd7TOeme9f8raYP6QDfaKntdkkkokUeldCyGN4t+cKFTw8TG0HmLDZR+kVOUA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GhIYm7qihXq2EcYauQ7XvvUF1wbNHwrAAQlOQMYMVPI=; b=klMwDNV9ydJIKhwiY7LkZFFKm6
 piiyNr3FdSk1bBpcCUWxl2Wp2m/Ydh4N735pQ2YP6PJjoqXMz5hDmggMz7tVs7xVTRqpliSLw4kei
 SYrPWP0DLPNdNgjGm6il09UKdQPYVct5V3cUEC6bMTxJp6inbAZSIBPLxJH/vbqrH2JI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1smVsl-0000oh-KN for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Sep 2024 10:08:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AFEE35C448A;
 Fri,  6 Sep 2024 10:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068BC4CEC4;
 Fri,  6 Sep 2024 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725617268;
 bh=FCSv6cJ5FuPF/zRuRCjlJnApaDNcik03hhh2o208Kdw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=REG6L9wf7TZO56IfPnqKdeu+elBvPdpxYpEZi8N/byczUXM2hmHqq4uvSOqVvjIkX
 GSeYRk7VV15c5yPk3/aE+rvTQgsbNCf+ch9V1kPPN3Mrxp0xALkpuqYJtvL7R/WdqN
 c0fAWAON305uFyKffeSh/TUJRZhS2ybUGnByIEyeaJq0ge1lY/Io+gSYrQIV65Q8+w
 xgpdMgUl+zKqS/oWd8LEKTGtdXcV+NSMhpDVnLpQoGwSNwDjasqDSUwvIT3RfCfAt7
 VTv+br6eWWaBS/HbuGT44PfvGIhIMdoegt9Pup+HuprhF06MnNYYpsJDaUop+1iDPN
 EeIu391794a/g==
Message-ID: <d5505e7f-19db-44dd-8c3f-5b43cfff6b29@kernel.org>
Date: Fri, 6 Sep 2024 18:07:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240906083117.3648386-1-bo.wu@vivo.com>
Content-Language: en-US
In-Reply-To: <20240906083117.3648386-1-bo.wu@vivo.com>
X-Headers-End: 1smVsl-0000oh-KN
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned
 sections if EAGAIN happens"
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Wu Bo <wubo.oduw@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC85LzYgMTY6MzEsIFd1IEJvIHdyb3RlOgo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0
IDAyOjUwOjExUE0gKzA4MDAsIENoYW8gWXUgd3JvdGU6Cj4+IE9uIDIwMjQvMi84IDE2OjExLCBX
dSBCbyB3cm90ZToKPj4+IE9uIDIwMjQvMi81IDExOjU0LCBDaGFvIFl1IHdyb3RlOgo+Pj4+IEhv
dyBhYm91dCBjYWxsaW5nIGYyZnNfYmFsYW5jZV9mcygpIHRvIGRvdWJsZSBjaGVjayBhbmQgbWFr
ZSBzdXJlIHRoZXJlIGlzCj4+Pj4gZW5vdWdoIGZyZWUgc3BhY2UgZm9yIGZvbGxvd2luZyBhbGxv
Y2F0aW9uLgo+Pj4+Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgIGlmIChoYXNfbm90X2Vub3VnaF9mcmVl
X3NlY3Moc2JpLCAwLAo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdFVF9TRUNfRlJPTV9T
RUcoc2JpLCBvdmVycHJvdmlzaW9uX3NlZ21lbnRzKHNiaSkpKSkgewo+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGYyZnNfZG93bl93cml0ZSgmc2JpLT5nY19sb2NrKTsKPj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdGF0X2luY19nY19jYWxsX2NvdW50KHNiaSwgRk9SRUdST1VORCk7
Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gZjJmc19nYyhzYmksICZnY19jb250
cm9sKTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyID09IC1FQUdBSU4pCj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmMmZzX2JhbGFuY2VfZnMoc2JpLCB0
cnVlKTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyICYmIGVyciAhPSAtRU5P
REFUQSkKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2VycjsK
Pj4+PiAgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4KPj4+IGYyZnNfYmFs
YW5jZV9mcygpIGhlcmUgd2lsbCBub3QgY2hhbmdlIHByb2NlZHVyZSBicmFuY2ggYW5kIG1heSBq
dXN0IHRyaWdnZXIgYW5vdGhlciBHQy4KPj4+Cj4+PiBJJ20gYWZyYWlkIHRoaXMgaXMgYSBiaXQg
cmVkdW5kYW50Lgo+Pgo+PiBPa2F5Lgo+Pgo+PiBJIGd1ZXNzIG1heWJlIEphZWdldWsgaGFzIGNv
bmNlcm4gd2hpY2ggaXMgdGhlIHJlYXNvbiB0byBjb21taXQKPj4gMmU0MmI3ZjgxN2FjICgiZjJm
czogc3RvcCBhbGxvY2F0aW5nIHBpbm5lZCBzZWN0aW9ucyBpZiBFQUdBSU4gaGFwcGVucyIpLgo+
IAo+IEhpIEphZWdldWssCj4gCj4gV2Ugb2NjYXNpb25hbGx5IHJlY2VpdmUgdXNlciBjb21wbGFp
bnRzIGFib3V0IE9UQSBmYWlsdXJlcyBjYXVzZWQgYnkgdGhpcyBpc3N1ZS4KPiBQbGVhc2UgY29u
c2lkZXIgbWVyZ2luZyB0aGlzIHBhdGNoLgoKSSdtIGZpbmUgdy8gdGhpcyBwYXRjaCwgYnV0IG9u
ZSBhbm90aGVyIHF1aWNrIGZpeCB3aWxsIGJlIHRyaWdnZXJpbmcKYmFja2dyb3VuZCBHQyB2aWEg
ZjJmcyBpb2N0bCBhZnRlciBmYWxsb2NhdGUoKSBmYWlsdXJlLCBvbmNlCmhhc19ub3RfZW5vdWdo
X2ZyZWVfc2VjcygsIG92cF9zZWdzKSByZXR1cm5zIGZhbHNlLCBmYWxsb2NhdGUoKSB3aWxsCnN1
Y2NlZWQuCgpSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgoKVGhhbmtzLAoK
PiAKPiBUaGFua3MKPiAKPj4KPj4gVGhhbmtzLAo+Pgo+Pj4KPj4+Pgo+Pgo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdAo+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dAo+PiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2xpbnV4LWYyZnMtZGV2ZWwK
