Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B4C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 06:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G875BVy9Xks+atJEQFWyPLedL3PXgnJvZ3dxKdaJTMs=; b=daMPYC4nN6mGJHSFVNIKVjPP7F
	9mE9wK0y/zu9uCqO+gCiOHD1OkQe5wNgtvMTD0ekqb1WfVpYdv3F3KGk3k33+JTIZLlF2dg19c4PH
	cWku36udEy7QBOE21UdXbSss0+hGls8qIBm1PHQMV193cXLu9EatmbxkzRaCIix26CPs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wulRV-00013F-Bj;
	Fri, 14 Aug 2026 06:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b45d4071d3315f6a5e0d+8391+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wulRB-00012x-3a for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 06:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=00WqtERUtnYBEUzQd0/SsEG+LWqmr6egKXeBQhrAo2I=; b=RbNMC58lmEt7/C5hS5/fDbHmgF
 eMIwSvt2t7em1muxy0oyKo2qF9Fozpu+efKEEQ+RpqO8lTdCMjM3E8qfgYtH6re1/uTSInGNvH1KM
 26csrY6zKa2+Q5Q2ah14wsl+NAi4jC1EE/3khPdPXSZR/VvygOeltBRfWi6WMm3XydtE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=00WqtERUtnYBEUzQd0/SsEG+LWqmr6egKXeBQhrAo2I=; b=cem3P4YzfymEpv8hcddqSeNVIg
 acRO2dBfSE6aJP2dF+m7wFdsCewwdJgyeMpcn3HtQ9mlw772tgt+ytGNW6UkhstK587xLl8YhsKv+
 s0vdIFzhuZ9BOLHZLPhpe0IFCnfmY/HLhmDNGswAv1xh23JArkOpG0kXuvRlYgWAWM8U=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wulRA-0001O5-Hy for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 06:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=00WqtERUtnYBEUzQd0/SsEG+LWqmr6egKXeBQhrAo2I=; b=WsNtQ8TniakQxZNdnuggvJh74C
 OE+4sgkHXEZuda9o7TCIN8ZpLZKayt5lMhfPBdi9qDc9BllPvmwc41LE3Qr0O6NB/jVAV2LwQuFig
 FlIYI5FxGw1AG6pjRP5HOMuYO5WfUr8kHRcZ5XmnhP5l608QVpHTXsW/QRiOF9QYwFUb+EdK34tUE
 XdU8zGpWXJQx8aCNuUFimFxp5McV/biDcAuI44NAc+pepbC7nfgSfQjLeLxMmXbAsHtq7BhOwpN9J
 r7MJ/rT1jha6cCGI6WlKmC2yAcqtpZJ5m7y8EPyTIiQMCzeTMqJ9JXrKo+i+hgy46uCKXsdA/qzEI
 gu1YioiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wulR0-000000022L3-2Xh4;
 Fri, 14 Aug 2026 06:30:31 +0000
Date: Thu, 13 Aug 2026 23:30:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <an62BorNrc-IX228@infradead.org>
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
 <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wulRA-0001O5-Hy
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Cc: linux-block@vger.kernel.org, Daeho Jeong <daehojeong@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, kernel-team@android.com,
 Pavel Machek <pavel@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBBdWcgMTAsIDIwMjYgYXQgMDk6NTM6MTRBTSAtMDcwMCwgRGFlaG8gSmVvbmcgd3Jv
dGU6Cj4gT24gTW9uLCBBdWcgMTAsIDIwMjYgYXQgOTozNOKAr0FNIEJhcnQgVmFuIEFzc2NoZSA8
YnZhbmFzc2NoZUBhY20ub3JnPiB3cm90ZToKPiA+IFRoaXMgaW5mb3JtYXRpb24gd2FzIHNoYXJl
ZCBlYXJsaWVyIHdpdGggRGFlaG8KPiA+IChodHRwczovL2IuY29ycC5nb29nbGUuY29tL2lzc3Vl
cy81MTU0NzAzMDkjY29tbWVudDQ1KTogWyAuLi4gXQoKVGhpcyBkb2VzIG5vdCBzZWVtIHRvIGJl
IGluZm9ybWF0aW9uIGF2YWlsYWJsZSB0byB0aGUgcHVibGljLgoKPiBmMmZzIHRocmVhZHMgYXJl
IGFscmVhZHkgZnJlZXphYmxlOiBmMmZzX2djIGFuZCBmMmZzX2Rpc2NhcmQgYXJlCj4gYWxyZWFk
eSByZWdpc3RlcmVkIHdpdGggc2V0X2ZyZWV6YWJsZSgpIGFuZCBjYWxsIHRyeV90b19mcmVlemUo
KS4KPiBIb3dldmVyLCBhIHJhY2Ugd2luZG93IGV4aXN0czogYSB0aHJlYWQgY2hlY2tzIGZyZWV6
aW5nKCkgKGZhbHNlKSwKPiBjYWxscyBzdWJtaXRfYmlvKCksIGFuZCBnZXRzIHRyYXBwZWQgaW5z
aWRlIF9fYmlvX3F1ZXVlX2VudGVyKCkuCj4gQmVjYXVzZSBpdCBnZXRzIGJsb2NrZWQgYmVmb3Jl
IHJlYWNoaW5nIHRyeV90b19mcmVlemUoKSwgaXQgdHJpZ2dlcnMgYQo+IFBNIGZyZWV6ZXIgdGlt
ZW91dC4KClRoaXMgZG9lcyBzb3VuZCB2ZXJ5IG11Y2ggbGlrZSBhIGJsb2NrIGxheWVyIGZyZWV6
aW5nIGlzc3VlLgoKPiBQb2ludCB0YWtlbi4gQXNpZGUgZnJvbSB0aGlzIGYyZnMgcGF0Y2gsIEkg
YWdyZWUgdGhhdCBhZGRyZXNzaW5nIHRoaXMKPiBhdCB0aGUgYmxvY2sgbGF5ZXIgb3IgUE0gc3Vi
c3lzdGVtIGxldmVsIHdvdWxkIGJlIGEgbXVjaCBjbGVhbmVyLAo+IHN5c3RlbS13aWRlIHNvbHV0
aW9uLgo+IEnigJlsbCBnaXZlIG1vcmUgdGhvdWdodCB0byBob3cgd2UgY2FuIHByb3Blcmx5IHNv
bHZlIHRoaXMgcmFjZQo+IGNvbmRpdGlvbiBmb3IgdGhlIGVudGlyZSBzeXN0ZW0sIGFuZCBJJ2xs
IGxvb3AgaW4gdGhlIHJlbGV2YW50Cj4gUE0vYmxvY2sgbWFpbnRhaW5lcnMgaWYgYSB2aWFibGUg
Z2VuZXJpYyBhcHByb2FjaCBlbWVyZ2VzLgoKVGhhbmtzLCBpdCB3b3VsZCBiZSBncmVhdCB0byBm
aXggdGhpcyBwcm9wZXJseS4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
