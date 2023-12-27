Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9D2C46CD4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Dec 2023 04:47:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rILpJ-0006jL-HG;
	Wed, 27 Dec 2023 04:47:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rILpI-0006jF-Ki
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Dec 2023 04:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lyN992BGFjHA6TRuHdGbdnKpOy+ApgNHc3R/aMJk1uo=; b=dyilYAX59NOtKFob4U2AiONr+D
 AHE9+wqRWXRMwFRPSf1h4wO1IVA59Yx3TYL3jZiBOFrR0XWarH69rw3/MZz9fp7TAp53zafaQg+Tr
 STJE0ZN4ATFlcnC2oP++j9gmAZbAZjYXjVe46+YN7sH5VQQX4efVbZ2mXk2AD88FSN48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lyN992BGFjHA6TRuHdGbdnKpOy+ApgNHc3R/aMJk1uo=; b=jIgRW5p/FLv8eQ57mWT/13ZIMz
 JyJARGQKlY7qOKhlMAJlMN+ZEf61C8P+T7qh7xv7zVTQcGFiM/iroCIJhU6ti9W5L73Eove3aVs3N
 yGetJvsjIQT9Hk04aX410D88EhSgNgJEc1Z2OP2Wl/gV5MzsIxEOdR3aXeJcO6WPgEW0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rILpC-00037o-Oz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 Dec 2023 04:47:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2819ACE1192;
 Wed, 27 Dec 2023 04:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE51C433C9;
 Wed, 27 Dec 2023 04:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703652426;
 bh=Bya6H8l4ZYjrp08ewGs9e/R44BsH5FpR2joYGBAIj2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lA9HuoFzlqbivy/PM58EG3aEtqKIuHa65hFvtoODtMxrOA7U/bkz0MX46x0REde94
 lmwKoFVFN4WIi1Hvd6EHfbOgX7RmY9rfh/oIVfsrwrcN3tHqyO419OfZEBq3zPLQAN
 E068JGv+6TDeSJKkdyQ8eLt53+ATJ1InaASpgNnvJjL24pCITGFXJzJhfx77epL4go
 s7LDN854oVq3Fd+U3KTq0k5aefS7py+p1AbzDzneUBiIqtD5m0lA7Bq0flRYsegAX0
 ncXHI4pvnfKOs8ICKq5/utgWQWyt0q4zsU1AORTAgBySeWbyyycB3SXHLjq4qtcE4v
 8ItCUp6ZUPrug==
Date: Tue, 26 Dec 2023 22:47:01 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Message-ID: <20231227044701.GC4240@quark.localdomain>
References: <20231213040018.73803-1-ebiggers@kernel.org>
 <20231213040018.73803-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213040018.73803-3-ebiggers@kernel.org>
X-Headers-End: 1rILpC-00037o-Oz
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: move release of block devices to
 after kill_block_super()
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
Cc: linux-fscrypt@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Dec 12, 2023 at 08:00:17PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Call destroy_device_list() and free the f2fs_sb_info from
> kill_f2fs_super(), after the call to kill_block_super().  This is
> necessary to order it after the call to fscrypt_destroy_keyring() once
> generic_shutdown_super() starts calling fscrypt_destroy_keyring() just
> after calling ->put_super.  This is because fscrypt_destroy_keyring()
> may call into f2fs_get_devices() via the fscrypt_operations.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/f2fs/super.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Jaegeuk and Chao, when you have a chance can you review or ack this?  I'm
thinking of taking patches 2-3 of this series through the fscrypt tree for 6.8.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
