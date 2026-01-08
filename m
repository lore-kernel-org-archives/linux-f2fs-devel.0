Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4206FCF6A8B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ul5bXf4ySPS4KnFuIp03hnR4ac1ErMYAX1kDaMfjIn0=; b=UsOLVSIHGXvkqbU0ce/sE1HFE1
	qDjso3B+sg+SpX0Vjslw+jf5hvJ/+ah6iKaj6H2S8GIF6+e7fy3PIp/Nfvhxovi+R/vlj91CP3Z2A
	PzAp6kk+kKKOqQauGyTKzmg5U/qqlTIGMppmIUNHFV92zYHjnIOH54C3iaj+m82dC3Y4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdmFC-0007SF-SV;
	Thu, 08 Jan 2026 09:23:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vdmFC-0007Rz-EW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jan 2026 09:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JnidiJA/UulDYjF6s1SanOZrsIoiQibefRhK2glabco=; b=BBXGxk8UBQLdLZnqLNvd08rMDf
 FEbY5aDyEaylB21scYibflzoO/F96siarl2M46hWuMbSHkav4OtCVrH5Ur12sHRFeVJCvrHnbbc6R
 cgfc7q4G73XtBfht4UKfsbjkuznAFrPRgGve2By4kFJbaavML7kCF5L7j1cbc3RZRV4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JnidiJA/UulDYjF6s1SanOZrsIoiQibefRhK2glabco=; b=h7ca1Wa5TjYUxH8gJPqplyONLq
 UiZ+U8Jzv/NUPzQT41VyuRDv4HLAaLtB3+wt6KS9GPy++uA8V+S0jJveThZ672bsKp5oKeR3+ZPu1
 91I2JfrH7rfgPnMKcucRyomZt8t2Bo+qGCfvVJ1D2SWN1H8aKPeVyrEhDdX/JBGlqdr8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdmFB-0000uE-Ti for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jan 2026 09:23:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 870A443FC5;
 Thu,  8 Jan 2026 09:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F93C116C6;
 Thu,  8 Jan 2026 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767864219;
 bh=EzZbmWi0Ae3MR5seeMt67qb7nX2NVZq6FalMDcWCzJI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=tfbPC6M1BkWyupJkKknJTyGvVa1NZ8OFAUUItB5Y/D+eKvL4WFQv4wbDMAAejsxbH
 +fXZh3Q58xJKE5XbSCAhht5SkwiS4G5NHFVEf3zRPMu1O//Ea9KPu+GilwzS2VUv9O
 6W5UZiMdFPldDThPtkbLCRJcsCIQHAZKcg0KEn+v90aC56r3fDTsVLSnjJXU3+5L0e
 hBppqIdvZSETHYILQKhY3cYKnWZY9Aq5HbKGy/V97HmB1zqtVr46RF3ZyBlWq7qeqn
 BWwZ8I/ZArNoli2Sk0njwSnPbWL+d0knRcg4ABoMupDUr3W5K6lrW2BWh3FQCtdnOu
 J+D8vDG3r/MAw==
Message-ID: <b6193f5d-7d0a-4770-afdf-127851072450@kernel.org>
Date: Thu, 8 Jan 2026 17:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260105153101.152892-1-nzzhao@126.com>
 <aV3OQu3ea5-DgzmT@google.com>
 <10088351.1d0d.19b9b64c92b.Coremail.nzzhao@126.com>
Content-Language: en-US
In-Reply-To: <10088351.1d0d.19b9b64c92b.Coremail.nzzhao@126.com>
X-Headers-End: 1vdmFB-0000uE-Ti
Subject: Re: [f2fs-dev] [PATCH v1 0/5] f2fs: fix large folio read corner
 cases for immutable files
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
Cc: Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMS84LzIwMjYgMTA6MTcgQU0sIE5hbnpoZSBaaGFvIHdyb3RlOgo+IEhpIEtpbSwKPiBBdCAy
MDI2LTAxLTA3IDExOjA4OjUwLCAiSmFlZ2V1ayBLaW0iIDxqYWVnZXVrQGtlcm5lbC5vcmc+IHdy
b3RlOgo+Pj4gSGkgTmFuemhlLAo+Pj4KPj4+IGZ5aSAtIEkgYXBwbGllZCB0aGUgYmVnaW5uaW5n
IHR3byBwYXRjaGVzIGZpcnN0Lgo+Pj4KPj4+IFRoYW5rcywKPj4+Cj4gCj4gVGhhbmtzIGZvciBh
cHBseWluZyBteSBzbWFsbCBjaGFuZ2VzLgo+IAo+IEJ5IHRoZSB3YXksIEnigJlkIGxpa2UgdG8g
ZGlzY3VzcyBvbmUgbW9yZSB0aGluZyBhYm91dCB0ZXN0aW5nIGZvciBsYXJnZSBmb2xpb3MuCj4g
SXQgc2VlbXMgdGhlIGN1cnJlbnQgeGZzdGVzdHMgY292ZXJhZ2UgbWF5IG5vdCBiZSBzdWZmaWNp
ZW50LiBXb3VsZCBpdCBiZQo+IHdlbGNvbWUgZm9yIG1lIHRvIGNvbnRyaWJ1dGUgc29tZSBuZXcg
dGVzdCBjYXNlcyB1cHN0cmVhbT8KCkdyZWF0LCBwbGVhc2UgZ28gYWhlYWQsIG5ldyB0ZXN0Y2Fz
ZSBjYW4gYmUgYWRkZWQgaW50byB0ZXN0cy9mMmZzLyBkaXJlY3RvcnkuCgo+IAo+IEFsc28sIEkg
dGhpbmsgbGFyZ2UtZm9saW8gZnVuY3Rpb25hbGl0eSBtaWdodCBhbHNvIG5lZWQgYmxhY2stYm94
IHRlc3Rpbmcgc3VjaAo+IGFzIGZhdWx0LWluamVjdGlvbiwgd2hlcmUgd2UgZm9yY2UgY2VydGFp
biBwYXRocyB0byByZXR1cm4gZXJyb3JzIGFuZCB2ZXJpZnkKPiBiZWhhdmlvciB1bmRlciBmYWls
dXJlcy4gSeKAmWQgYXBwcmVjaWF0ZSB5b3VyIHRob3VnaHRzLgoKSXQncyBmaW5lIHRvIGludHJv
ZHVjZSBhIG5ldyBoZWxwIGYyZnNfZnN2ZXJpdHlfdmVyaWZ5X3BhZ2UoKSBhbmQgaW5qZWN0IGVy
cm9yCnRoZXJlLgoKVGhhbmtzLAoKPiAKPiBUaGFua3MsCj4gTmFuemhlCj4gCj4gCj4gCj4gCj4g
Cj4gCj4gCj4gCj4gCj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
