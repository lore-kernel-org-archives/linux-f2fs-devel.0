Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6104CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aL4AEyvXyHz0KbJ8gvK97oFrBi5Dmf0EJ6rviRxboRY=; b=TCBjFEkWuOLy9cFX/ldxNdZl64
	F0SGj0f5Ih3Bnoi1vJYrTQ+UWOt1pHMBNC/dXSykqGOs3aAGF76tFpuqGgeh9hQXm8+dup3/sr3+c
	fFHAcNOiphaPoU1vhsW+S5shds90pNdLZc+nlcoBD47ANMMifk4lMPBrbWNEnAxfSV2M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhe9-0007Fq-Qy;
	Tue, 12 May 2026 07:35:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhe8-0007Fj-9s
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aQd55LajexpGLYq3nw5x9rGxQqldh5nydMlhuddhLnk=; b=gCOpZEsnl8hDcxYd09bscurK/G
 bu0Z4wzG1aQR+be2DOafvyrApLaSEJchzHU82AckCmV11LcgF6JWErO+2r+gMaPqPqPd2ZGtdzFJF
 9K84EziCF40/Ve7TsiFJBP6wNtGoy6Ojtl8HHgyHXMqT5+kIH0zCDUy2qIipZpJW19Hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aQd55LajexpGLYq3nw5x9rGxQqldh5nydMlhuddhLnk=; b=EEfuYr1yNhFw2Jju05PRtj+DLg
 clKkVHxBVtvUxChd4SbGCOOUWoAgX/iR2B1m4xgaD9drULGqfM8GuHNGwKjF4/DmWvL8x/tOpuU1t
 ptdw6R7HcOcWZQBM3vaLYfKJAHrz5lieiqtw3yTe2Y8Sm/bGgvhuxGUo5RzTA8tgUxT0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhe3-0002az-OE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:35:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A921843713;
 Tue, 12 May 2026 07:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46713C2BCB0;
 Tue, 12 May 2026 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778571301;
 bh=s/liCqvWpwzbf+Ors2mYM2xHnFEKG2Ez9stMzBy2CUA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CLRtx/UM0efOdLrvjlbvsWzTtbQven4c5sLOwml2whwHzcCcqJMd7bCclOjdEZ20O
 UXxIhdcs2qt054/GJeHr0t3YI+ofKCUnTiipODTRt7ADIbQc9JEeasCk+xcR9aOeew
 Gi2vyLOb8+DJmCJSkdwtTx7cYb0d2rd57ymwPj9cTLhIyaPzAcrpNE2ILkt0jpqzId
 HkOrmdLVr7An8cZeKIiB8TlR7lnPGvQeaV1/jiF25kcRdf1pFOXUoCx3u/XpqANN/f
 VbTmMIKsMtE+C2cPfrNbk1D6HdbQj6D6wJTNfrXhs2YxKIj4hNpJ6iQIh+220eEt3H
 1k5nf0s7jSIog==
Message-ID: <b2fab68d-541a-4f58-85a6-a304134cf127@kernel.org>
Date: Tue, 12 May 2026 16:34:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-10-hch@lst.de>
X-Headers-End: 1wMhe3-0002az-OE
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
> Only the file operation method knows what block device we'll swap
> to.  So move down setting sis->bdev and the special blockdev flag
> into ->swap_activate.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below. Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> @@ -141,7 +141,6 @@ int generic_swap_activate(struct file *swap_file, struct swap_info_struct *sis)
>  		continue;
>  	}
>  	return 0;
> -

whiteline change.

>  bad_bmap:
>  	pr_err("swapon: swapfile has holes\n");
>  	return -EINVAL;
-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
