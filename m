Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FCDCDE010
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rqs5H6XP5Cl2vNxnd4f3sQ+Emf0hHvmQISBKAS9BmM4=; b=lgLW84LaeXyktXWBLBBDnEtBkS
	rRIsg/Jc2bMOJJNMagrg4iOsoq3Xuhm3fsiNfx9yl3ivIQJtK0toxlY4C5Zw8qior+OMKLrpOIOIP
	nwGrh/Gy4B1lLidoM6v03GzIjb5XLrpDvq3Fo2CrQFoAp0UDIyOZPS/F/xJ0oGU4dUgg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcyyU-0000qK-Jk;
	Fri, 26 Jun 2026 05:19:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wcyyB-0000pe-Ra
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:19:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nt4FBocEgPqrU1taoXujy9Zuimzf1zfjP0xaZnLMHdM=; b=GcrLVXK8f7CP+V2wkphiwdxt9d
 VpEulq0C4Bdrve0Grm26Zr+j6ti84bB9/sxtkW7vekSh1/NvOpDwi8wKAzlRIRHMPGpEWqi6b/WrP
 JYRYzrmAt6swAlk2JclOsjrMhfYDSifChTmsHtPuAlHZUgLbHYRYA8U5xE8Bk3IatMOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nt4FBocEgPqrU1taoXujy9Zuimzf1zfjP0xaZnLMHdM=; b=j0aqCwWmWHfSDDp/xZO9+PGec3
 ViWaeVUfijjW+nfrOVHquJNDP+CKf0MZZNxH9ulknRjSxhXIMAabkKDq58NLYE0wBQm1L03KLL8L1
 Z8VxF4SRfPExUpzojoZzNec5sP99Gblc/UCdd1SiTmqW43U32bndtiuz/Jct9DchPo/w=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcyxv-0000S8-0n for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:18:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3B55268B05; Fri, 26 Jun 2026 07:18:52 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:18:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260626051851.GD9043@lst.de>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624050334.124606-5-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wcyxv-0000S8-0n
Subject: Re: [f2fs-dev] [PATCH 04/16] fscrypt: Fully disallow IV_INO_LBLK_32
 with s_blocksize != PAGE_SIZE
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2026 at 10:03:22PM -0700, Eric Biggers wrote:
> FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32 with s_blocksize != PAGE_SIZE works
> only with the fs-layer implementation of file contents encryption, not
> blk-crypto.  This is a problem for standardizing on blk-crypto.
> 
> Fortunately, no one should be using this combination anyway.  It doesn't
> make sense because the entire point of IV_INO_LBLK_32 is to support
> inline encryption hardware that is limited to 32-bit DUNs.
> 
> Thus, fully disallow IV_INO_LBLK_32 with s_blocksize != PAGE_SIZE.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
