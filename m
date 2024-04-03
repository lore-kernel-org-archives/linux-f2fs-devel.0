Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC4CD128A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 16:56:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rs3u1-0000eq-Jt;
	Wed, 03 Apr 2024 16:55:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bfoster@redhat.com>) id 1rs3tx-0000ec-2N
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 16:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qcFGTIgsVpRcFHL+8n4bltIbe5BCiFbcUwE7alUYftc=; b=MwKSjIKlyjdxIv16XhKCTUwsXo
 pCBRgsoQ27kMIkipXV96/FXLp6DtO6hXQya4vQQ3c6L/vFUmxzRGtTRiC0dCq9D/C9LzH7qDq3tWY
 X8xAOXdWDe23qk5zjQISxc/n3D+0zT/UkKHDueoKpxhoJJxrdN7rUL78VTAs59s2gOIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qcFGTIgsVpRcFHL+8n4bltIbe5BCiFbcUwE7alUYftc=; b=lLejmMvyJdjx1NFbHe1vbT5a+V
 xS8GnYyXL4hOEdS98PrQxL4FmTrL3Kl7sxwKtNfd1jRtMFtVoC69iW+Zc16K5OPQdQwQqtW2enh03
 DeZyighoy5mCEFnPYm+5g4vSemzOT8LAV0Q0zTDc+5uyKtzgVMshlbnKSLU6NWv5KHS4=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rs3tw-0006GQ-1A for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 16:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712163345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcFGTIgsVpRcFHL+8n4bltIbe5BCiFbcUwE7alUYftc=;
 b=cvCVs7iV7A+JfWN53Q97HNARkewbq+uFP9e7q05+d/BRkZVgmP3NiTcKsogyHuQIAparZN
 OmdrhjsbTyziMBDa0TVtNCmXCvHtJ1MfN37/MrjtLjLWZSKzmTE7n7392jQr/E5IgwO+oj
 Wtwl+lJKq5jEGBGem6rfDHc6e72AmFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-BbaFp3e6P9SwSkyIW3LFsQ-1; Wed, 03 Apr 2024 12:55:41 -0400
X-MC-Unique: BbaFp3e6P9SwSkyIW3LFsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 479DF88D4E8;
 Wed,  3 Apr 2024 16:55:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 300632024517;
 Wed,  3 Apr 2024 16:55:39 +0000 (UTC)
Date: Wed, 3 Apr 2024 12:57:37 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Message-ID: <Zg2Kgdn42odZVUtE@bfoster>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Headers-End: 1rs3tw-0006GQ-1A
Subject: Re: [f2fs-dev] [PATCH v3 01/13] fs: fiemap: add physical_length
 field to extents
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
Cc: linux-bcachefs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-btrfs@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@meta.com,
 =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 03, 2024 at 03:22:42AM -0400, Sweet Tea Dorminy wrote:
> Some filesystems support compressed extents which have a larger logical
> size than physical, and for those filesystems, it can be useful for
> userspace to know how much space those extents actually use. For
> instance, the compsize [1] tool for btrfs currently uses btrfs-internal,
> root-only ioctl to find the actual disk space used by a file; it would
> be better and more useful for this information to require fewer
> privileges and to be usable on more filesystems. Therefore, use one of
> the padding u64s in the fiemap extent structure to return the actual
> physical length; and, for now, return this as equal to the logical
> length.
> 
> [1] https://github.com/kilobyte/compsize
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  Documentation/filesystems/fiemap.rst | 28 +++++++++++++++++-------
>  fs/ioctl.c                           |  3 ++-
>  include/uapi/linux/fiemap.h          | 32 ++++++++++++++++++++++------
>  3 files changed, 47 insertions(+), 16 deletions(-)
> 
...
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 661b46125669..8afd32e1a27a 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -138,7 +138,8 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  	memset(&extent, 0, sizeof(extent));
>  	extent.fe_logical = logical;
>  	extent.fe_physical = phys;
> -	extent.fe_length = len;
> +	extent.fe_logical_length = len;
> +	extent.fe_physical_length = len;

Nit: Why start this field out as len if the next patch adds the param
and defaults to zero? Not that it matters that much due to the next
patch (which seems logical), but wouldn't it make more sense to set this
to 0 from the start?

Brian

>  	extent.fe_flags = flags;
>  
>  	dest += fieinfo->fi_extents_mapped;
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 24ca0c00cae3..3079159b8e94 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -14,14 +14,30 @@
>  
>  #include <linux/types.h>
>  
> +/*
> + * For backward compatibility, where the member of the struct was called
> + * fe_length instead of fe_logical_length.
> + */
> +#define fe_length fe_logical_length
> +
>  struct fiemap_extent {
> -	__u64 fe_logical;  /* logical offset in bytes for the start of
> -			    * the extent from the beginning of the file */
> -	__u64 fe_physical; /* physical offset in bytes for the start
> -			    * of the extent from the beginning of the disk */
> -	__u64 fe_length;   /* length in bytes for this extent */
> -	__u64 fe_reserved64[2];
> -	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> +	/*
> +	 * logical offset in bytes for the start of
> +	 * the extent from the beginning of the file
> +	 */
> +	__u64 fe_logical;
> +	/*
> +	 * physical offset in bytes for the start
> +	 * of the extent from the beginning of the disk
> +	 */
> +	__u64 fe_physical;
> +	/* logical length in bytes for this extent */
> +	__u64 fe_logical_length;
> +	/* physical length in bytes for this extent */
> +	__u64 fe_physical_length;
> +	__u64 fe_reserved64[1];
> +	/* FIEMAP_EXTENT_* flags for this extent */
> +	__u32 fe_flags;
>  	__u32 fe_reserved[3];
>  };
>  
> @@ -66,5 +82,7 @@ struct fiemap {
>  						    * merged for efficiency. */
>  #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
>  						    * files. */
> +#define FIEMAP_EXTENT_HAS_PHYS_LEN	0x00004000 /* Physical length is valid
> +						    * and set by FS. */
>  
>  #endif /* _UAPI_LINUX_FIEMAP_H */
> -- 
> 2.43.0
> 
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
