Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC57EDEC1E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OCJCYpjtrLuyqXNbKBfrra6Tp592OTxF5Ecl97Zix3I=; b=JCC/a+qw/UEd9Gg/XMh3JA1Mf6
	xwVtpfQmbDhO+EGVFIyKLuateHLU4egvoZAy25tR3mUC4VLpurQoq/HbxEixu0zrr/1+Q+Wd26qPB
	al8aEA6ajiDGeJrGNkIrcueapz56IiVedy+f0VCdEF4d+Qg2Ht7XnAU3oOuP0Z2c3IbM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxh38-00075T-6L;
	Wed, 04 Mar 2026 07:53:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vxh36-00075L-FT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IOIkUKFBTbu5ZzzettXD+361BqkNBwvkoNQsD/Za8Lg=; b=hqJor7vxqZ7iI2dAmUa9VViw4R
 qcts9R4GEZXoKuC7rbz5Vy8w06QkQlCfnnvPYkv4QyWQbYu73sHlyFWxoeE8xgrQdsRY7DqQhBl5Z
 vAT6N9F2osDe+es4b2/WN9lHWeUOvgTVzKgR2WV7EVkiPH4fOPAkwG5Hgwb24MbYHYyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IOIkUKFBTbu5ZzzettXD+361BqkNBwvkoNQsD/Za8Lg=; b=XLtIIsT6WT/N7Sb020FDo82slf
 /laHiCsThvi9EAnURC1f76z4Y904SszY0n9Q2tw3b6sqHQeQ2XGA267KGXjhtMXGB8enGyOx8C2jd
 CdnUM9yQUX/Uepip3km6oQPWDdH0Lsk3gczOga09zTPimdXiqHOcH8+j1/+j6aFqBIu8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxh36-0008PS-Mo for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:53:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0810F6132F;
 Wed,  4 Mar 2026 07:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A42FC19423;
 Wed,  4 Mar 2026 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772610814;
 bh=cqOFBwDRyiwFrwYJzDEF/M3/hy2SmgO1cJHU5rE3SQE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=kc+7L5FepMpDbtxUAF2pVUGExzNt24rIome3JcXsMUgSbi4GF3rnt1cbVxzmDLpWo
 JW+CHNPuzDTZKSOHE4DuMpjX06k/FRWuMwOZ8IY3z5EBg9uLsCYULYsgM2NrGWHIpV
 cUfSHWcAi/9RHLyyfK92JU8oQnjLtJQsbMAi1v4pfUBa5ffE311mOquDSXYlXRm6oK
 MhljSkLRadx99/Mg/zaN1zm5GtZIP6Tbj6q9FWMqOpQ9mumqWDcKPqgZulMApPSkXT
 9BC46TwzSGEm9PdxW1S9TlooDe5KGnnPp+9V2bmXy5anOllBiSeeLBgLn7aKXgAaZg
 twI9AjjXq8UAA==
Message-ID: <c0353a3a-418c-4d91-a8e2-1c39c65b6b2b@kernel.org>
Date: Wed, 4 Mar 2026 15:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260221201316.22025-1-ebiggers@kernel.org>
Content-Language: en-US
In-Reply-To: <20260221201316.22025-1-ebiggers@kernel.org>
X-Headers-End: 1vxh36-0008PS-Mo
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unreachable code in
 f2fs_encrypt_one_page()
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
Cc: Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/2/22 04:13, Eric Biggers wrote:
> Since commit 52e7e0d88933 ("fscrypt: Switch to sync_skcipher and
> on-stack requests") eliminated the dynamic allocation of crypto
> requests, the only remaining dynamic memory allocation done by
> fscrypt_encrypt_pagecache_blocks() is the bounce page allocation.
> 
> The bounce page is allocated from a mempool.  Mempool allocations with
> GFP_NOFS never fail.  Therefore, fscrypt_encrypt_pagecache_blocks() can
> no longer return -ENOMEM when passed GFP_NOFS.
> 
> Remove the now-unreachable code from f2fs_encrypt_one_page().
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/all/d9dc2ee1-283d-4467-ad36-a6a4aa557589@suse.cz/
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
