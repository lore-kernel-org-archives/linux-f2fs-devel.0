Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D73BC61DFB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Feb 2026 20:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ydrOZQh2fYqFy6XvCkYiIEwCMuEzfpWMP4Z3RiwcZTc=; b=Y/1cx1NsR7uLwgxBYrpczPAOEE
	wtMTs8RR7vfD5mZVG3Amwlu/RL8Q0GlTfWGn8cZO9JaeESbFqZM8PkSOaWwCv/f8+YzCSDJPNQBFj
	Db2c2Bc+2N8x6NgsqVELU3cqCOVmvSl4mqyVImKwNHV/J5uadYjlBxaocNnKVyen4tsk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vttEu-0002yL-T6;
	Sat, 21 Feb 2026 20:06:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vttEH-0002wm-Gf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 20:05:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pvPas3UDgY5PKp/J22NXOJGt9f12HnY609mP3p8dH8o=; b=fjRjqXikeG1YbGyi23V1JivIYr
 BiVFykF3fJ43m6n0rWbdAKxBWvYc+EdYaWc4X1AEeuxPlJ/aGSKbBxDakz+TXE/pF/0PGrYvCQBOX
 JKYRUcPcPJ2d29Rk7o1+3olTOhou//YusPtSFzNelObrLWZgbl9+IwhmEbdqxRgdT+uI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pvPas3UDgY5PKp/J22NXOJGt9f12HnY609mP3p8dH8o=; b=PCF2F1Bg7W4hWVNLC5lJCsho3d
 mMk6gUFa2bWk4eAW9tvhxTrJZUoQtdaetD6dNZbqQQmzvTqRWVi3FNsXEtnszDHzvrfnNrQSTL5Xn
 +sIgnZidbBxUJ0GHY4xehLQ24lgGGkJOQLAnCaEcqSeYfnNHoy+034MLZieKxcL73sKA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vtsv8-0002rL-50 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 19:45:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BAB96441E6;
 Sat, 21 Feb 2026 19:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F133C4CEF7;
 Sat, 21 Feb 2026 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771703136;
 bh=mFAiNSqsxsqOGhfi6yj61qlg7slrIqYxPPaW9O9Y60Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WEZIXEN5w0Og2gE8E5z1Crq5s0FzNg+4ErjWqUno3rrR6oGCcIwt4lcuDLkDA8fWz
 aePZIq5glzoDCW7sKquOgRO3wXyVzqSdF9RY5GAq51Ms3BwoWLd365JqTysUvqnpro
 Brik2jrScJl13SC7NgueLJwNS/zoIpD4qE+gF/JmgcpVEfEhGdFDp8SblpEv4wiGHj
 UOPSUdg3+HqN78Ow6K4gpBWm708TRX7ZYlIHfvORn6ka71mA4Vs/eWVSh7WVMj5T6Q
 XBaHgX/w3rR6cXkvfIt7zO8bPtKtMFeosoRV5zShagB0YEHK4UlfaKYdvmVJVJcZ6H
 oMKy2BZ3PpWkQ==
Date: Sat, 21 Feb 2026 11:45:34 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260221194534.GC2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-4-hch@lst.de>
X-Headers-End: 1vtsv8-0002rL-50
Subject: Re: [f2fs-dev] [PATCH 3/9] fscrypt: pass a byte offset to
 fscrypt_set_bio_crypt_ctx
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Feb 18, 2026 at 07:14:41AM +0100, Christoph Hellwig wrote:
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
[...]
> /**
>  * fscrypt_set_bio_crypt_ctx_bh() - prepare a file contents bio for inline
>  *				    crypto
>  * @bio: a bio which will eventually be submitted to the file
>  * @first_bh: the first buffer_head for which I/O will be submitted
>  * @gfp_mask: memory allocation flags
>  *
>  * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
>  * of an inode and block number directly.

Similarly, the above needs "block number" => "file position"

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
