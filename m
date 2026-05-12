Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42942CD4855
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPU4Z+n5nRPzr8pnpqfqjNdZnOwNt73HY8hvgXjRuB0=; b=LAG56IWSRriBpN32eEaKg93dpr
	WcjXbm0+NIPy9ndGnvZlu/euxo2ue9lUvL5zMElY/voFcTtHTzexNGr+SOfVUVqqZmk8yobCPSVhF
	grnppkTAWNL96XAl+PFty62GB0ZE57bdQQeCCoqTInhezsW4YqiFg9kXRj2j0TOd/MVo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhMF-0001kt-SD;
	Tue, 12 May 2026 07:16:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhME-0001kn-Pf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBLSwE5Enw9Fad3QZn3L13j2+aYvfA+zzUyoH7S7mbo=; b=CN92KlsNez27NzCsHFCERj8QCx
 2LlNnBE839VD5WzQEc9peS3RPNS8Zy1FbxDJEKK9jzUsK8xlVbtje4E1pp7pFpmumyMvMbegAoilt
 ZfkV4tThy6f8ZEcqFBhzzo1ejyhe5sNKmGO6l/Ok/P8uGo7Th0kcqhbJ/HE2ECPEu/HQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TBLSwE5Enw9Fad3QZn3L13j2+aYvfA+zzUyoH7S7mbo=; b=PVTWbitsTVOSMsTBo0RCHGsdmx
 s0seeLt9Ppo86rfLZqXQnFoKa//gUxFSPtGDSoIw6hOQ28TjclUph2ay7DkTPWD/sMjoMXhKtvxTm
 EeeilJTniemXRAWHp9cjbDio25jz8f+S/wZuejVwt7JtkCCb5wLbiA2nfGe/FyStCW7c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhMB-0001NO-NN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:16:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CFCEA436DD;
 Tue, 12 May 2026 07:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E618C2BCB0;
 Tue, 12 May 2026 07:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778570198;
 bh=nKvg9k4i7+/FdWNoLP39fTA2AIBDoli2gh2Xo3a+f/U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iw4jpXeE4iOTdRjtloaKtPRiHhRVD9YnDTRygvwHuj80w5Lt/GGuuos8S4Oa2+A4Z
 ID/zwJQlick5hyU4VnwvCe6wnMLR7YE22/84JKPCiUWJE12TXkUBwoW0Xx2o2Y8Kbc
 Ap/ZZWL6+KNR2fCfNMakCOH0HKbNFRfpp1IrwQXWNsRyjaMjSJeMwYfsVxKH432Az1
 +dfRTVKY4Sm+FYuGhaV5UL3jeIxzP+M4dP/TEGsLXxEyYvgq3HndEAdgOqi/TC+AS7
 TEKARoNX1z73Pn9qVgIaMUuNjbH5til+b8JTgFa+cH3UZwf+2RvwC+OmA8Cl38G9Nu
 8hXejv+EqUw2Q==
Message-ID: <f34a9a4e-3d0a-405b-a3be-6400642bde44@kernel.org>
Date: Tue, 12 May 2026 16:16:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-4-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-4-hch@lst.de>
X-Headers-End: 1wMhMB-0001NO-NN
Subject: Re: [f2fs-dev] [PATCH 03/12] swap,
 fs: move swapfile operations to struct file_operations
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
> The swap operations have nothing to do with the address_space, which is
> used for pagecache operations.  Move them to struct file_operations
> instead.  This will allow moving the block device special cases into
> block/fops.c subsequently.
> 
> Pass struct file first to ->swap_activate as file operations typically
> get the file or iocb as first argument and use swap_activate instead of
> swapfile_activate in all names to be consistent.
> 
> Note that while the trivial iomap wrappers are moved to a new file when
> applicable to keep them local to the file operation instances, complex
> implementation are kept in their existing place.  It might be worth to
> move them in follow-on patches if the maintainers desire so.
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
