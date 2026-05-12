Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD6ACD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ur+TFqfBNDLrSKd9eh/8rmj73rtMEHJEkWZjdnaFbeY=; b=Z3mgA/lkTQV5pP5ZxH2Pi5YEuN
	+n+nvX5XuUYFbr9Zkir+2rH7xnzoHY3fv3OAt4rawk+4v6kELfppFkNDrNho90n7b/26VU04nax7l
	LxkcJfEV8wsZR/WGKmo6oFIm5xsh3q8gVNaWHGl+VQ6zGBdIyFLIv1vEHWBcOaTKaxek=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhg0-00047G-5h;
	Tue, 12 May 2026 07:37:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhfy-000479-UY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w12lu7nseUQxZUHBdqD28dHw2n8tKEPk3ZHzgNt0uFg=; b=V3TYJqfZK3YzxapewUaDy2yr+8
 zKXyvl7Ofvp5IwFR/K8vuYvVtHGMytu9Qw1QFfnvkhRHAvT3bF0rZVy6ITicivLAYYoV7cMwhyq3A
 LDSfDvEbeMgsPVaTJWySwhrIk16KSSfRC0fCN4kRjGfVVHvQ+YUexz3pOO7ku23EkCdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w12lu7nseUQxZUHBdqD28dHw2n8tKEPk3ZHzgNt0uFg=; b=XAkIcHGVxgWJaqHpdzTgBLFpdp
 mrpg0U+1UEP+bV/M7aWbeq/5WbG7kUTy1kiakou0CNHi5RsdQCVVZvmInVy/quIYVKMDFt+5Qy0aK
 Mp+s4b9r/XSsP770u1J3RZ9TTS3ASw/axUn1kPXWWdqpc3yWluRIcGPsJ64FwiFkG1Z0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhfw-0002jI-Ep for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:37:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 49F0060103;
 Tue, 12 May 2026 07:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8939CC2BCB0;
 Tue, 12 May 2026 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778571423;
 bh=bzanpAxEPPJIoNF8P3OMFoiwVgRrhSjMj0dl8KCwj2c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k6zwxl4KfffulQWkSQ/v1DaJteq+3tZVRQwppay1B0fSQw+n/Up8vr10OmjPy01oZ
 S9RbJ2oBP2l1fSUFTx2f2rjJdBSErkAnfKc3t1TUv+Mu3oSLC1iyL/GU/gfjeqQ/nw
 7lqxmqLEbpmy0GIolmLaSccs+DOcojFy8BT23/XpKOM0EX5Apejzh34zCu8A/q5iOx
 6FMe55PI21UUcouy3PLDDTJmU2cygCtArcW5fCFdj4DYZEjPbpGPfE2WnH/lo8MMDP
 Sy1+6j5/OR8RfSxsobzgeZEWhoXRA36sq61Xw/fBIWWXBSV/z2L3QPA1yFLoLjn0wr
 cU6GrRMFxCkHQ==
Message-ID: <f2ef2baa-0527-4905-aa4b-b88ab38a51d7@kernel.org>
Date: Tue, 12 May 2026 16:36:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-12-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-12-hch@lst.de>
X-Headers-End: 1wMhfw-0002jI-Ep
Subject: Re: [f2fs-dev] [PATCH 11/12] swap: move struct swap_extent to
 swapfile.c
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
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> struct swap_extent is only used inside of mm/swapfile.c, so move it
> there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
