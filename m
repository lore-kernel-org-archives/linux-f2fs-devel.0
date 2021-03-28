Return-Path: <SRS0=BUZT=I2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC8C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Mar 2021 14:44:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199EC61972
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Mar 2021 14:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199EC61972
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lQWed-0006j0-Ik; Sun, 28 Mar 2021 14:44:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <andrealmeid@collabora.com>) id 1lQWeY-0006ii-LA
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Mar 2021 14:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=idHgjA8kRGVAzdjvCeOAh+K5GDf6ZS34pXdNpiVaaXk=; b=i1OtT1XDJ2vXGPfMr89qQzz73e
 /pX5nTmOr4Qcwr8xVKJOrAz5T7oilaxymWWfN486l/7XxvQnxKpQVUXcrHg+TCHpXO1E1pXBzfmcx
 OpOnCYMq1k2b8di9UkCvQ9EelcomhtL8t7+TjE9ZLmhG7+f4El/2bTZC0NagGfMIFe7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=idHgjA8kRGVAzdjvCeOAh+K5GDf6ZS34pXdNpiVaaXk=; b=N
 zMVJx7HqZIrvV7KV76IXlM66O16fvBjrUqeryHzwrcVVGvhP0enZd+m3Wr+RSDvKlnze9ypxvaxgW
 ux/N9j8adYiFNvblnH7VpBlkrDhqwOHS7dpEVSIKzHtVjW5ojSmAONN7hzvRD095Y1FkDjoxWkm4U
 VTnXHLSO+okhh9Lc=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lQWeT-004h9A-CG
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Mar 2021 14:44:34 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: tonyk) with ESMTPSA id C1F5E1F42808
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Date: Sun, 28 Mar 2021 11:43:53 -0300
Message-Id: <20210328144356.12866-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Headers-End: 1lQWeT-004h9A-CG
Subject: [f2fs-dev] [PATCH 0/3] fs: Fix dangling dentries on casefold
 directories
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
Cc: kernel@collabora.com, Daniel Rosenberg <drosen@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 krisman@collabora.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8sCgpUaGlzIHBhdGNoc2V0IGZpeGVzIGEgYnVnIGluIGNhc2UtaW5zZW5zaXRpdmUgZGly
ZWN0b3JpZXMuIFdoZW4gSQpzdWJtaXR0ZWQgYSBwYXRjaHNldCBmb3IgYWRkaW5nIGNhc2UtaW5z
ZW5zaXRpdmUgc3VwcG9ydCBmb3IgdG1wZnNbMF0sCkFsIFZpcm8gbm90ZWQgdGhhdCBteSBpbXBs
ZW1lbnRhdGlvbiBkaWRuJ3QgdGFrZSBpbiBhY2NvdW50IHByZXZpb3VzCmRlbnRyaWVzIHRoYXQg
dGhlIGRpcmVjdG9yeSBjb3VsZCBoYXZlIGNyZWF0ZWQgYmVmb3JlIGJlaW5nIGNoYW5nZWQuCkZ1
cnRoZXIgaW52ZXN0aWdhdGlvbiBzaG93ZWQgdGhhdCBuZWl0aGVyIGV4dDQgb3IgZjJmcyBhbHNv
IGRvZXNuJ3QgdGFrZQp0aGlzIGNhc2UgaW4gY29uc2lkZXJhdGlvbiBhcyB3ZWxsLgoKKiBXaHkg
Y2FuJ3Qgd2UgaGF2ZSBuZWdhdGl2ZSBkZW50cmllcyB3aXRoIGNhc2Vmb2xkPwoKVGhlIGFzc3Vt
cHRpb24gdGhhdCB0aGUgZGlyZWN0b3J5IGhhcyBubyBkZW50cmllcyBjYW4gbGVhZCB0byBhIGJ1
Z2d5CmJlaGF2aW9yIChub3RlIHRoYXQgc2luY2UgdGhlIGRpcmVjdG9yeSBtdXN0IGJlIGVtcHR5
IHdoZW4gc2V0dGluZyB0aGUKY2FzZWZvbGQgZmxhZywgYWxsIGRlbnRyaWVzIHRoZXJlIGFyZSBu
ZWdhdGl2ZSkuIEltYWdpbmUgdGhlIGZvbGxvd2luZwpvcGVyYXRpb24gb24gYSBtb3VudGVkIGV4
dDQgd2l0aCBjYXNlZm9sZCBzdXBwb3J0IGVuYWJsZWQ6Cgpta2RpciBkaXIKbWtkaXIgZGlyL0MJ
IyBjcmVhdGVzIGEgZGVudHJ5IGZvciBgQ2AgKGRlbnRyeSBEKQpybSAtciBkaXIvQwkjIG1ha2Vz
IGRlbnRyeSBEIGEgbmVnYXRpdmUgb25lCgpOb3csIGxldCdzIG1ha2UgaXQgY2FzZS1pbnNlbnNp
dGl2ZToKCmNoYXR0ciArRiBkaXIvCSMgbm93IGRpci8gaXMgYSBjYXNlZm9sZCBkaXJlY3RvcnkK
bWtkaXIgZGlyL2MJIyBpZiBoYXNoIGZvciBgY2AgY29sbGlkZXMgd2l0aCBkZW50cnkgRAoJCSMg
ZF9jb21wYXJlIGRvZXMgYSBjYXNlLWluc2Vuc2l0aXZlIGNvbXBhcmUKCQkjIGFuZCBhc3N1bWVz
IHRoYXQgZGVudHJ5IEQgaXMgdGhlIG9uZSB0byBiZSB1c2VkCmxzIGRpci8JCSMgVkZTIHVzZXMg
dGhlIG5hbWUgYXQgZGVudHJ5IEQgZm9yIHRoZSBmaW5hbCBmaWxlCkMJCSMgYW5kIGhlcmUncyB0
aGUgYnVnCgpJbiB0aGF0IHdheSwgYWxsIG5lZ2F0aXZlIGRlbnRyaWVzIGF0IGRpci8gd2lsbCBi
ZWNvbWUgZGFuZ2xpbmcgZGVudHJpZXMKdGhhdCBjYW4ndCBiZSB0cnVzdGVkIHRvIGJlIHVzZWQg
YW4gd2lsbCBqdXN0IHdhc3RlIG1lbW9yeS4KClRoZSBwcm9ibGVtIHdpdGggbmVnYXRpdmUgZGVu
dHJpZXMgaXMgd2VsbC1rbm93LCBhbmQgYm90aCB0aGUgY3VycmVudApjb2RlIGFuZCBjb21taXRz
IGRvY3VtZW50cyBpdCwgYnV0IHRoaXMgY2FzZSBoYXNuJ3QgYmVlbiB0YWtlbiBpbgpjb25zaWRl
cmF0aW9uIHNvIGZhci4KCiogUmVwcm9kdWNpbmcKCkdpdmVuIHRoYXQgdGhlIGJ1ZyBvbmx5IGhh
cHBlbnMgd2l0aCBhIGhhc2ggY29sbGlzaW9uLCBJIGFkZGVkIHRoZQpmb2xsb3dpbmcgc25pcHBl
dCBhdCB0aGUgYmVnaW5uaW5nIG9mIGdlbmVyaWNfY2lfZF9oYXNoKCk6CgpzdHItPmhhc2ggPSAw
OwpyZXR1cm4gMDsKClRoaXMgbWVhbnMgdGhhdCBhbGwgZGVudHJpZXMgd2lsbCBoYXZlIHRoZSBz
YW1lIGhhc2guIFRoaXMgaXMgbm90IGdvb2QKZm9yIHBlcmZvcm1hbmNlLCBidXQgaXQgc2hvdWxk
IG5vdCBicmVhayBhbnl0aGluZyBBRkFJSy4gVGhlbiwganVzdCBydW4KdGhlIGV4YW1wbGUgc2hv
d2VkIGluIHRoZSBsYXR0ZXIgc2VjdGlvbi4KCiogRml4aW5nCgpUbyBmaXggdGhpcyBidWcsIEkg
YWRkZWQgYSBmdW5jdGlvbiB0aGF0LCBnaXZlbiBhbiBpbm9kZSwgZm9yIGVhY2ggYWxpYXMKb2Yg
aXQsIHdpbGwgcmVtb3ZlIGFsbCB0aGUgc3ViLWRlbnRyaWVzIGF0IHRoYXQgZGlyZWN0b3J5LiBH
aXZlbiB0aGF0CnRoZXkgYXJlIGFsbCBuZWdhdGl2ZSBkZW50cmllcywgd2UgZG9uJ3QgbmVlZCB0
byBkbyB0aGUgd2hvbGUgZF93YWxrLApzaW5jZSB0aGV5IGRvbid0IGhhdmUgY2hpbGRyZW4gYW5k
IGFyZSBhbHNvIHJlYWR5IHRvIGJlIGRfZHJvcGVkIGFuZApkcHV0ZWQuCgpUaGVuLCBhdCBleHQ0
IGFuZCBmMmZzLCB3aGVuIGEgZGlyIGlzIGdvaW5nIHRvIHR1cm4gb24gdGhlIGNhc2Vmb2xkCmZs
YWcsIHdlIGNhbGwgdGhpcyBmdW5jdGlvbi4KClRoYW5rcywKCUFuZHLDqQoKWzBdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAyMTAzMjMxOTU5NDEuNjk3MjAtMS1hbmRy
ZWFsbWVpZEBjb2xsYWJvcmEuY29tL1QvI20zMjY1NTc5MTk3MDk1Yjc5MmVlOGI4ZThiN2Y4NGE1
OGMyNWM0NTZiCgpBbmRyw6kgQWxtZWlkYSAoMyk6CiAgZnMvZGNhY2hlOiBBZGQgZF9jbGVhcl9k
aXJfbmVnX2RlbnRyaWVzKCkKICBleHQ0OiBQcmV2ZW50IGRhbmdsaW5nIGRlbnRyaWVzIG9uIGNh
c2Vmb2xkIGRpcmVjdG9yaWVzCiAgZjJmczogUHJldmVudCBkYW5nbGluZyBkZW50cmllcyBvbiBj
YXNlZm9sZCBkaXJlY3RvcmllcwoKIGZzL2RjYWNoZS5jICAgICAgICAgICAgfCAyNyArKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGZzL2V4dDQvaW9jdGwuYyAgICAgICAgfCAgMyArKysKIGZz
L2YyZnMvZmlsZS5jICAgICAgICAgfCAgNCArKysrCiBpbmNsdWRlL2xpbnV4L2RjYWNoZS5oIHwg
IDEgKwogNCBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspCgotLSAKMi4zMS4wCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
