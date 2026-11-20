Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDB606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZUE0oySA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lo5uqVrW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=INwOCaWO;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWUwWl3D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QbwKc32O89w2WKzg3CsyRk71OPFqyGF6v3IV+PsblTg=; b=ZUE0oySA9v+pPfZg5R1Shbgd4V
	Z/U6t80o33BMjuRIqylH7GJZs8Dty7BsXMVcRRtcPaB+ax5gzMN3bvWP/X3BwC0/fsELK8awmE26r
	FNJU87y5V3b3K2CdFTyE2VgKWdUIWBvgluVwj1GcUZXijAosas4BmJEp8BLEQppYF000=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUWvw-000000000Cm-1RQo;
	Fri, 20 Nov 2026 22:18:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ebiggers@kernel.org>) id 1xUWva-000000000CG-280U
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=khFB9XB534fgekb/CoE+7bFIpuAhIcZTTRU6XFAnt0g=; b=Lo5uqVrWJ8XhlnCOl9LqHPbmdk
 sHvL4Wm4jplLojsaZrHkwRGL+kfpAgY0Bc01gV4VgF32QHq6vbDB+EBDviWpVysNWKMuqERXgODvH
 UU6M60OpuRAKCvfeEv84SDDqfJ5eyO4wAUmw5wsFKOltoGy6hVgBpUi2sUx6VMNcwV2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=khFB9XB534fgekb/CoE+7bFIpuAhIcZTTRU6XFAnt0g=; b=INwOCaWObmOaX+NRWC1QkvFMAh
 UZpBJoIU/DXfX3ymhhrk2K/ZdzKB9g7p0J+LFQvKwcbga8xadqhvKmrVwJhycjhoVzV8Uf/Ehvs2u
 6FwJVzNWn8JHhvfJfmIxAW7DsOSjIcOKD8AX442IRVMY7FbUZIccORcrttpfDDpVIjfc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUWvZ-000000003HJ-0Y5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 22:17:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33C3561F4A;
 Fri, 20 Nov 2026 22:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE581F000CA;
 Fri, 20 Nov 2026 22:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795213066;
 bh=khFB9XB534fgekb/CoE+7bFIpuAhIcZTTRU6XFAnt0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RWUwWl3Dzutjwu7Cy5jDblMhQtXMeEMH4EURZs10qbRLcoXjIZ7zcCpQAVc+Naejb
 l/HCvk8+QixPPXRUj7W2pxs1bVmhbNVSQCR2qD+y/1Ux9RSGs6CE2n8X2DCp5zGjbQ
 /CZYQdVIC93EmoqO8hA8heVbGIFhudDBJ1uC2HxllmaCFeSNbqBKrjHt4hqwXwr663
 ljXB95Jbz6123HBoN4nK/hmKhn/5h7romjkMCkp1itCWaHuiw0yaD7gAkCoOyZBqgA
 hVOZEJOOYcMRoCo6oadpSJYrrkm1Jc1fTUZC8H0aul3fHOIdrLW6xv+TBKRnrfKvXw
 3UOjZpRfSTChA==
Date: Fri, 20 Nov 2026 22:17:44 +0000
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261120221744.GB3048696@google.com>
References: <20261120155032.187246-1-aalbersh@kernel.org>
 <20261120155032.187246-4-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261120155032.187246-4-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUWvZ-000000003HJ-0Y5p
Subject: Re: [f2fs-dev] [PATCH v3 3/7] fs,
 fsverity: add I_VERITY_BUILDING inode state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity <fsverity@lists.linux.dev>, Christian Brauner <brauner@kernel.org>,
 tytso@mit.edu, linux-f2fs <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 viro@zeniv.linux.org.uk, fsdevel <linux-fsdevel@vger.kernel.org>,
 jaegeuk@kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 04:50:25PM +0100, Andrey Albershteyn wrote:
> + * I_VERITY_BUILDING	fs-verity is being enabled on the inode: the Merkle
> + *			tree is under construction.  The file is effectively
> + *			read-only to userspace; the only writes happening are
> + *			for the fs-verity metadata.

Existing dirty data can still be written out though, right?

> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 61fe96ccdff6..e02f79682e33 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -36,11 +36,12 @@ struct fsverity_operations {
>  	 * @filp: a readonly file descriptor for the file
>  	 *
>  	 * The filesystem must do any needed filesystem-specific preparations
> -	 * for enabling verity, e.g. evicting inline data.  It also must return
> -	 * -EBUSY if verity is already being enabled on the given file.
> +	 * for enabling verity, e.g. evicting inline data.
>  	 *
>  	 * i_rwsem is held for write.
>  	 *
> +	 * I_VERITY_BUILDING is set on the inode for the duration of enabling.
> +	 *
>  	 * Return: 0 on success, -errno on failure
>  	 */
>  	int (*begin_enable_verity)(struct file *filp);

The new sentence doesn't seem relevant here, as the flag isn't set
during this method call.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
