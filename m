Return-Path: <SRS0=DrP0=44=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DDC10DCE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:50:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B83D20637;
	Wed, 11 Mar 2020 02:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cIccZMD1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WhIzG9Yb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1ystG14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B83D20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jBrRw-0001VY-E9; Wed, 11 Mar 2020 02:50:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jBrRu-0001VQ-UG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 02:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RZtszH8req/1LBC2esh+VUMRBdbkcw8Pdin2SkwtUco=; b=cIccZMD1J/ju95MYk5YYvM9YTF
 qDdq12kqB/0pZs7YNWOEnwTo8Bnd60VXm/uMfG6D+rcJx6wQg4tHGetFKtvrWu7jiVQLPAOmpCf7W
 E1m8ofXl4xeswJhsmgyzwLl5rFO0OqDkviVtuIzq5q0hOLwPUnALmm3kc8g/SBBG8oLA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RZtszH8req/1LBC2esh+VUMRBdbkcw8Pdin2SkwtUco=; b=WhIzG9Yb5cXTM2i9+8R864yWNk
 6PwuRk2a25Vbxa/jIlwgFdqRuGWeg1ripx+2OXlUtAlzUlDfTx1+ArNww7C2ioiQa1ZzDXzy0iNYY
 HeOXm8pzaWMOjrzBS+Qn9sXsk+fxBhXYDxkWSC0ctPxExv5ds7L7WhUxinXkwwdLRsQM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jBrRs-004RMB-PW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 02:50:22 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EEDF220637;
 Wed, 11 Mar 2020 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583895015;
 bh=WtFMlLzPcU5BhKbuP+2KrYUwWQYx4yq+ffF9gx1TB4c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q1ystG146lhrdx1ECKnmJ+Gnq00mbVBlMiA9vl3KTF2QmR+GOfMmrR5MUFTybatwD
 ThRVdbuIcu+qHCl2Wz2aEBWCuC4NftqLMjxqT/L71EMNo6OcqflzJzuhbLoePIfyuA
 VrMxS7K+quWwG8SXU9sNgRZ+IAiV6J6SxXax9fNI=
Date: Tue, 10 Mar 2020 19:50:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20200311025013.GB46757@gmail.com>
References: <20200305084138.653498-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200305084138.653498-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jBrRs-004RMB-PW
Subject: Re: [f2fs-dev] [PATCH] fscrypt: don't evict dirty inodes after
 removing key
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 05, 2020 at 12:41:38AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> After FS_IOC_REMOVE_ENCRYPTION_KEY removes a key, it syncs the
> filesystem and tries to get and put all inodes that were unlocked by the
> key so that unused inodes get evicted via fscrypt_drop_inode().
> Normally, the inodes are all clean due to the sync.
> 
> However, after the filesystem is sync'ed, userspace can modify and close
> one of the files.  (Userspace is *supposed* to close the files before
> removing the key.  But it doesn't always happen, and the kernel can't
> assume it.)  This causes the inode to be dirtied and have i_count == 0.
> Then, fscrypt_drop_inode() failed to consider this case and indicated
> that the inode can be dropped, causing the write to be lost.
> 
> On f2fs, other problems such as a filesystem freeze could occur due to
> the inode being freed while still on f2fs's dirty inode list.
> 
> Fix this bug by making fscrypt_drop_inode() only drop clean inodes.
> 
> I've written an xfstest which detects this bug on ext4, f2fs, and ubifs.
> 
> Fixes: b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/keysetup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 65cb09fa6ead..08c9f216a54d 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -538,6 +538,15 @@ int fscrypt_drop_inode(struct inode *inode)
>  		return 0;
>  	mk = ci->ci_master_key->payload.data[0];
>  
> +	/*
> +	 * With proper, non-racy use of FS_IOC_REMOVE_ENCRYPTION_KEY, all inodes
> +	 * protected by the key were cleaned by sync_filesystem().  But if
> +	 * userspace is still using the files, inodes can be dirtied between
> +	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
> +	 */
> +	if (inode->i_state & I_DIRTY_ALL)
> +		return 0;
> +
>  	/*
>  	 * Note: since we aren't holding ->mk_secret_sem, the result here can
>  	 * immediately become outdated.  But there's no correctness problem with
> -- 

Applied to fscrypt.git#for-stable for 5.6.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
