Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DC6C47258
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:13:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSqAu-0006Sp-1t;
	Thu, 25 Jan 2024 03:13:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rSqAt-0006Se-9G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ltawi/q+QwKIc79Ljr+y1UlrS+n25loM4V01eAT2Vyo=; b=nMcIdieyHOL2RyRgL8XyuO041i
 AbeI0dafj0u3Y1VUZTT2XJrkit9YwQN7Su0o7MVAbmeMeK2Hm+eSLDW1KYo77qTAPMP+d+znz5qPT
 Qn93nphVlQhcHp84KrkDBnQcowTVhsFoG7R+ZM0AhGpN7CMjN7pwcXcgfynQz/baNPPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ltawi/q+QwKIc79Ljr+y1UlrS+n25loM4V01eAT2Vyo=; b=RRhO/+cCB+Z6q5xP05BhIJ03jI
 NL9ewMzi/8wvozdHN0+OJoAy7W0Hf56S9a9sh46vsaVXJTye8jvuGHV2SHPDNofcfi/PThDBQ2ZuB
 QCECHpnHQ01cUawQWmkpuGnn1xxhIZuxaB0dS5SMEuOc/p9/RCToGpwZOkPuEO0SvFXE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rSqAr-0005tY-Mg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jan 2024 03:13:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8BB92CE32B7;
 Thu, 25 Jan 2024 03:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763FBC433C7;
 Thu, 25 Jan 2024 03:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706152373;
 bh=fRk1oYOWwebE3Gwdrh/Tnqsxt6v+AVSd7r7lMjh5y1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A00aORVzedzHs30RWLFcTiWlC03VdaDvQqDuKIAniFdAVLKuMFWQwxb59IXtBz2js
 biOOHxBJXNbV378sLsEZGXvS6lPyMptuibzGnJvQkqseD6lrRtyTeMKtB8mXtpbXSx
 4Pv1Ln6RLbqUw4p/jGh/OIqpEAo8vZua8MzySaGj2g6Rn+HM8ilr3C649ktYm+KQxq
 WhkYcxMLZRZcUiTXCT0TRYg30Qym+0RffALXDgmH3PKCar90DVOLimPGCPIgo7pfcf
 YTEAglBkTetGeXVcp+JEsx32RwjkZVRMtm6LCS7LJyGymi76fkcv/tS/ve/NGo1uxA
 +/ugfqmnbe8Cw==
Date: Wed, 24 Jan 2024 19:12:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <20240125031251.GC52073@sol.localdomain>
References: <20240119184742.31088-1-krisman@suse.de>
 <20240119184742.31088-5-krisman@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119184742.31088-5-krisman@suse.de>
X-Headers-End: 1rSqAr-0005tY-Mg
Subject: Re: [f2fs-dev] [PATCH v3 04/10] fscrypt: Drop d_revalidate once the
 key is added
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
Cc: tytso@mit.edu, amir73il@gmail.com, linux-f2fs-devel@lists.sourceforge.net,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 19, 2024 at 03:47:36PM -0300, Gabriel Krisman Bertazi wrote:
> /*
>  * When d_splice_alias() moves a directory's no-key alias to its plaintext alias
>  * as a result of the encryption key being added, DCACHE_NOKEY_NAME must be
>  * cleared.  Note that we don't have to support arbitrary moves of this flag
>  * because fscrypt doesn't allow no-key names to be the source or target of a
>  * rename().
>  */
>  static inline void fscrypt_handle_d_move(struct dentry *dentry)
>  {
>  	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
> +
> +	/*
> +	 * Save the d_revalidate call cost during VFS operations.  We
> +	 * can do it because, when the key is available, the dentry
> +	 * can't go stale and the key won't go away without eviction.
> +	 */
> +	if (dentry->d_op && dentry->d_op->d_revalidate == fscrypt_d_revalidate)
> +		dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
>  }

Is there any way to optimize this further for the case where fscrypt is not
being used?  This is called unconditionally from d_move().  I've generally been
trying to avoid things like this where the fscrypt support slows things down for
everyone even when they're not using the feature.

In any case, as always please don't let function comments get outdated.  Since
it now seems to just describe the DCACHE_NOKEY_NAME clearing and not the whole
function, maybe it should be moved to above that line.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
