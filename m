Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C077C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 24 Jul 2022 10:26:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oFYoH-0003Du-Fp; Sun, 24 Jul 2022 10:26:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oFYoG-0003Dk-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 10:26:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sbMEP+J+ofUQAvxmbDGamhikV7X69rs03DSSQOARQmY=; b=PW/1hysYl9pvdh0OH0EEEb2RQq
 ucfJCQf30d3bPf+7vOyEmyatmFE2MYrrfJpK3g5v0oxycj5tK6NrZ1oAW5Nx6tegURh8BrJN2Erbn
 6XrvhquONqqFBE3Qmrybgjx510pF8vrKCG5PXpMY8AFz74E7smpzd3C1UTLfGCD9dqTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sbMEP+J+ofUQAvxmbDGamhikV7X69rs03DSSQOARQmY=; b=JcDWVJkARG6gCQ78YAWNXhjHQk
 1ZIYfnwrWelN+JX0q8xT9CXom8kyCTTL2Zl4Qdh6j0VGknRNKCKxU+lY4RRuT7DGWadA/o/AULLHM
 VOMnFHQh7QkhvHeX+bUx4Mmd/73fD4+trtLp+Ge1YBPw70/MeHh1QzIR1WvAH+cgLm8k=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oFYoA-008oWO-CM
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 10:26:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 72FC4B80D62;
 Sun, 24 Jul 2022 10:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFFC3411E;
 Sun, 24 Jul 2022 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658658345;
 bh=llr3NpuOtsHJafurgE+1bQ5Ai0owsCdalYBPSeJB2ok=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nhwUVI+T0cKTEoyz/KO7x19M282NEi+oeGqWBgdbZMW5Sjwf7TgvBpMgdgk/9HCki
 /ZipPK4EMgLx8/SgMgiyKnhwNixw4I3jfzTVdSwGRQSB+JdAy5NrDUmcGMHi8L5BXa
 Tzny134OVZRyabb1SN1ov6mxmjvlcD73jStFSZwKrd2Q58txFveoJ+mwuDDJqqEO24
 WSOxyWIM1gs0PquPB2H7pmHb6dAfweVhON9a/z5Y/MgAAkOzuwWPDjOsduxQ6qzIW4
 q013bsNztDTFV7P3VFKPuOFslIJ36UXEmbTMaepLGo7UHXUqghI/zMInDxOJxZlinj
 EoJIFGPkXbbjA==
Message-ID: <daecf6fe-6e12-ea6f-5463-747fdd0dd52e@kernel.org>
Date: Sun, 24 Jul 2022 18:25:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Nick Terrell <terrelln@fb.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20220717083613.3861-1-fmdefrancesco@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220717083613.3861-1-fmdefrancesco@gmail.com>
X-Headers-End: 1oFYoA-008oWO-CM
Subject: Re: [f2fs-dev] [PATCH] f2fs: Delete f2fs_copy_page() and replace
 with memcpy_page()
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
Cc: Christoph Hellwig <hch@infradead.org>, Ira Weiny <ira.weiny@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMi83LzE3IDE2OjM2LCBGYWJpbyBNLiBEZSBGcmFuY2VzY28gd3JvdGU6Cj4gZjJmc19j
b3B5X3BhZ2UoKSBpcyBhIHdyYXBwZXIgYXJvdW5kIHR3byBrbWFwKCkgKyBvbmUgbWVtY3B5KCkg
ZnJvbS90bwo+IHRoZSBtYXBwZWQgcGFnZXMuIEl0IHVubmVjZXNzYXJpbHkgZHVwbGljYXRlcyBh
IGtlcm5lbCBBUEkgYW5kIGl0IG1ha2VzCj4gdXNlIG9mIGttYXAoKSwgd2hpY2ggaXMgYmVpbmcg
ZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBrbWFwX2xvY2FsX3BhZ2UoKS4KPiAKPiBUd28gbWFpbiBw
cm9ibGVtcyB3aXRoIGttYXAoKTogKDEpIEl0IGNvbWVzIHdpdGggYW4gb3ZlcmhlYWQgYXMgbWFw
cGluZwo+IHNwYWNlIGlzIHJlc3RyaWN0ZWQgYW5kIHByb3RlY3RlZCBieSBhIGdsb2JhbCBsb2Nr
IGZvciBzeW5jaHJvbml6YXRpb24gYW5kCj4gKDIpIGl0IGFsc28gcmVxdWlyZXMgZ2xvYmFsIFRM
QiBpbnZhbGlkYXRpb24gd2hlbiB0aGUga21hcOKAmXMgcG9vbCB3cmFwcwo+IGFuZCBpdCBtaWdo
dCBibG9jayB3aGVuIHRoZSBtYXBwaW5nIHNwYWNlIGlzIGZ1bGx5IHV0aWxpemVkIHVudGlsIGEg
c2xvdAo+IGJlY29tZXMgYXZhaWxhYmxlLgo+IAo+IFdpdGgga21hcF9sb2NhbF9wYWdlKCkgdGhl
IG1hcHBpbmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtlCj4gcGFnZSBmYXVs
dHMsIGFuZCBjYW4gYmUgY2FsbGVkIGZyb20gYW55IGNvbnRleHQgKGluY2x1ZGluZyBpbnRlcnJ1
cHRzKS4KPiBJdCBpcyBmYXN0ZXIgdGhhbiBrbWFwKCkgaW4ga2VybmVscyB3aXRoIEhJR0hNRU0g
ZW5hYmxlZC4gVGhlcmVmb3JlLCBpdHMKPiB1c2UgaW4gX19jbG9uZV9ibGthZGRycygpIGlzIHNh
ZmUgYW5kIHNob3VsZCBiZSBwcmVmZXJyZWQuCj4gCj4gRGVsZXRlIGYyZnNfY29weV9wYWdlKCkg
YW5kIHVzZSBhIHBsYWluIG1lbWNweV9wYWdlKCkgaW4gdGhlIG9ubHkgb25lCj4gc2l0ZSBjYWxs
aW5nIHRoZSByZW1vdmVkIGZ1bmN0aW9uLiBtZW1jcHlfcGFnZSgpIGF2b2lkcyBvcGVuIGNvZGlu
ZyB0d28KPiBrbWFwX2xvY2FsX3BhZ2UoKSArIG9uZSBtZW1jcHkoKSBiZXR3ZWVuIHRoZSB0d28g
a2VybmVsIHZpcnR1YWwgYWRkcmVzc2VzLgo+IAo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoIEhl
bGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPgo+IFN1Z2dlc3RlZC1ieTogSXJhIFdlaW55IDxpcmEu
d2VpbnlAaW50ZWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIE0uIERlIEZyYW5jZXNjbyA8
Zm1kZWZyYW5jZXNjb0BnbWFpbC5jb20+CgpSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJu
ZWwub3JnPgoKVGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
