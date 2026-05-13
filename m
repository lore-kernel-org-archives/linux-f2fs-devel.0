Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197E7CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2026 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCNW9f7Jtv34dhRcCiWXo0VDsasYRscuy9qAz7jIxAA=; b=ioEBSuKUezbBDn06Yq7J2kjxn6
	eEXLpscsi1Xm8fSzqr+b/liG0VpeI7O/WdiuAMwYmQsfT7J8nH1XrKHQkvLEMB6k+Wi3ZajBnG3Cg
	picUKFHjR/tbFk2XMjIhU9D4acQN9HtfmAImaw6mesMeZ9PmKWD7DIpR+Q+160s5skD0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wN4HT-0003H8-Gk;
	Wed, 13 May 2026 07:45:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wN4HK-0003Gu-HR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 07:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jfc9VamWO5q0xBx3b2s9XvXr4HRth56IxXIXv/8jUV8=; b=aB8Z1MYu9mMfefFBzzBijdo8rZ
 1L2AQYteYHp0TPn6N1WoLFqnnwQ6pvhRf8sd0IMVYl75K6A78l95a6EExBepUFyEfCPoaDEzVsfB6
 lpLU2dFdWj8tVpjjdxW+C/YB9eRRNLrE1jcg3ItMb0qFqmmdHit4kJdfDDuOpGrr1mCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jfc9VamWO5q0xBx3b2s9XvXr4HRth56IxXIXv/8jUV8=; b=gJhILEQ3hPVXMk5Ujq0jBjncAb
 R3KJbmApSZaCX0/L6nWbOLdt6fkItDc1AaTdPHCmFuhXESRL2d13314rs1Og+RX44h54/y8AYaKOW
 1AH99EjCJB5rSRP640trkLdPYHzTXR5+MckPKhOq79UY+ySm8lyk9Q59q4dkN2fDAW/c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wN4HG-0002mu-6u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 13 May 2026 07:45:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 21E5F43DB5;
 Wed, 13 May 2026 07:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B4FC2BCB7;
 Wed, 13 May 2026 07:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778658300;
 bh=Dg2nW1p160NOCn5umFdjytzvydm/ZD4Y8VIlSf+k0CM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W88QhGV5fNBgG29b6A8+2aMpfRcsRHQN/DvQSObUW7md2OERCUFlHgf1cKsHqoq2S
 8ykZnWkud0SccegE0umMkD4j5jJ7KgzhBrzoBcb9I/I9zNm6SNrd0Urp9aI7aA2mFH
 Ls43dph0TYLcQ7SHMgIKKiqIjYNGHdG0bRvkSKaUSVLbUqXi1S0+3eREdcpqS6vbou
 pjHmEbKTKNOrbnUGt7tcluhtcMyTN3bE6oKaewls6oT44KMpU3eYtzejZxITRlsKNU
 MrtDtAfOwb3/X7OZISUgYCyAwxQnZAGj2NCGbnTCksT5zjWWNFVhk+szDVycr1iBRH
 EXReRb+kSdmJg==
Message-ID: <acd6428b-a352-4f7b-a349-b2c9e341fd87@kernel.org>
Date: Wed, 13 May 2026 16:44:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
 <20260512170846.GJ9555@frogsfrogsfrogs> <20260513055806.GC1236@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260513055806.GC1236@lst.de>
X-Headers-End: 1wN4HG-0002mu-6u
Subject: Re: [f2fs-dev] [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-cifs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, linux-btrfs@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNS8xMy8yNiAxNDo1OCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24gVHVlLCBNYXkg
MTIsIDIwMjYgYXQgMTA6MDg6NDZBTSAtMDcwMCwgRGFycmljayBKLiBXb25nIHdyb3RlOgo+Pj4g
KwkvKiBPbmx5IG9uZSBiZGV2IHBlciBzd2FwIGZpbGUgZm9yIG5vdy4gKi8KPj4+ICsJaWYgKCFz
aXMtPmJkZXYpCj4+PiArCQlzaXMtPmJkZXYgPSBiZGV2Owo+Pj4gKwllbHNlIGlmIChiZGV2ICE9
IHNpcy0+YmRldikKPj4+ICsJCXJldHVybiAtRUlOVkFMOwo+Pgo+PiBTaG91bGQgdGhpcyByZXR1
cm4gZXJyb3IgaWYgdGhlIGJkZXYgaXMgem9uZWQ/ICBBRkFJQ1QgWEZTIGFuZCB6b25lZnMKPj4g
YWxyZWFkeSBndWFyZCBhZ2FpbnN0IHRoaXMsIGJ1dCBvdGhlciBmc2VzIG1pZ2h0IGJlIG1vcmUg
bmHDr3ZlLgo+IAo+IFllcywgbm93IHRoYXQgdGhlIGJkZXYgaXMgcGFzc2VkIGRvd24gdG8gYWRk
X3N3YXBfZXh0ZW50IHdlIGNvdWxkCj4gY29uc29saWRhdGUgdGhlIGNoZWNrIGhlcmUuCgpIbW1t
Li4uIFdpdGggem9uZWZzLCBzd2FwIGZpbGVzIGNhbiBiZSBjcmVhdGVkIG9uIHRvcCBvZiBjb252
ZW50aW9uYWwgem9uZQpmaWxlcy4gU28gZW5mb3JjaW5nICJubyBzd2FwIG9uIHpvbmVkIGRldmlj
ZSIgaGVyZSB3b3VsZCBicmVhayB0aGF0LgoKCi0tIApEYW1pZW4gTGUgTW9hbApXZXN0ZXJuIERp
Z2l0YWwgUmVzZWFyY2gKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
