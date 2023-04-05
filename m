Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE22C77B70
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 09:52:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjzoi-0005A8-9I;
	Wed, 05 Apr 2023 09:52:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1pjzog-0005A2-RV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 09:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5kxEOZs1Ac76OBwtijAiq1LEHzxrTF/ESnoZeBX1s5U=; b=dkk4zLFbA4FK77M9jDq6PLK1yd
 5UcNMu0TdTAy6giuUeXapxep7uhdVlK9oLf+2Bw5YM/P+aehi4/Sk13XzhfeE4A7o+YrchXbUTNyH
 DNoMH6XDv2PZdamPDr2MFxa1lYJrqJ5vwk44N729Ps/pTo80kkHuey6ko0qHaA93vuFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5kxEOZs1Ac76OBwtijAiq1LEHzxrTF/ESnoZeBX1s5U=; b=VN2Xdh9l0AjNkc0/lzPcKFcO2H
 ti5PMEWxHO8X9+Xe3+31xeMSvoduetVwPpZEY5NkfMWd8PcMKo7qJyS1wskKdgXgDFauPdJoPRW1C
 vDTzUP9GQ8TMEPc0QHTDi5/Fn7wwwX0f6ucINkGfCFt6jCD3CxOMHapllf2wQd3lIwOk=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pjzob-00FtRY-Kg for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 09:52:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A3AB20685;
 Wed,  5 Apr 2023 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680688340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kxEOZs1Ac76OBwtijAiq1LEHzxrTF/ESnoZeBX1s5U=;
 b=IRxH5dLldXbzWoseDDJFLON27UWQisexrdux6pTmZwMEJUh7+KDDgOL2FFGwMdw4qXX+88
 SZXtRstArd4pzrgcJ8oig7KPreFloNY/MGYHpRLp72bp2qfZlFYU7wFiZqAGyQ0vGW2203
 wLigaRb7GuLAIa/y7Wt2ZqyTi00uXvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680688340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kxEOZs1Ac76OBwtijAiq1LEHzxrTF/ESnoZeBX1s5U=;
 b=9GU3V54N4nWUFuOORZ946DHhtbHXxKXuPtMcQGot4qVFgX8PM9hEOJcrOnifZQlqrRHef3
 ++8hpDdRa+nWC8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E15F713A31;
 Wed,  5 Apr 2023 09:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rfgAN9NELWQFbwAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 05 Apr 2023 09:52:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 1E028A0729; Wed,  5 Apr 2023 11:52:19 +0200 (CEST)
Date: Wed, 5 Apr 2023 11:52:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20230405095219.fx2lw4dt25gn34ib@quack3>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Headers-End: 1pjzob-00FtRY-Kg
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported
 mailing list
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
Cc: brauner@kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ebiggers@google.com, djwong@kernel.org, amir73il@gmail.com,
 linux-unionfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, anand.jain@oracle.com,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 05-04-23 01:14:09, Zorro Lang wrote:
> The fstests supports different kind of fs testing, better to cc
> specific fs mailing list for specific fs testing, to get better
> reviewing points. So record these mailing lists and files related
> with them in MAINTAINERS file.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> 
> If someone mailing list doesn't want to be in cc list of related fstests
> patch, please reply this email, I'll remove that line.
> 
> Or if I missed someone mailing list, please feel free to tell me.
> 
> Thanks,
> Zorro
> 
>  MAINTAINERS | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09b1a5a3..620368cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -107,6 +107,83 @@ Maintainers List
>  	  should send patch to fstests@ at least. Other relevant mailing list
>  	  or reviewer or co-maintainer can be in cc list.
>  
> +BTRFS
> +L:	linux-btrfs@vger.kernel.org
> +S:	Supported
> +F:	tests/btrfs/
> +F:	common/btrfs
> +
> +CEPH
> +L:	ceph-devel@vger.kernel.org
> +S:	Supported
> +F:	tests/ceph/
> +F:	common/ceph
> +
> +CIFS
> +L:	linux-cifs@vger.kernel.org
> +S:	Supported
> +F:	tests/cifs
> +
> +EXT4
> +L:	linux-ext4@vger.kernel.org
> +S:	Supported
> +F:	tests/ext4/
> +F:	common/ext4
> +
> +F2FS
> +L:	linux-f2fs-devel@lists.sourceforge.net
> +S:	Supported
> +F:	tests/f2fs/
> +F:	common/f2fs
> +
> +FSVERITY
> +L:	fsverity@lists.linux.dev
> +S:	Supported
> +F:	common/verity
> +
> +FSCRYPT
> +L:      linux-fscrypt@vger.kernel.org
> +S:	Supported
> +F:	common/encrypt
> +
> +FS-IDMAPPED
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +F:	src/vfs/
> +
> +NFS
> +L:	linux-nfs@vger.kernel.org
> +S:	Supported
> +F:	tests/nfs/
> +F:	common/nfs
> +
> +OCFS2
> +L:	ocfs2-devel@oss.oracle.com
> +S:	Supported
> +F:	tests/ocfs2/
> +
> +OVERLAYFS
> +L:	linux-unionfs@vger.kernel.org
> +S:	Supported
> +F:	tests/overlay
> +F:	common/overlay
> +
> +UDF
> +R:	Jan Kara <jack@suse.com>
> +S:	Supported
> +F:	tests/udf/
> +
> +XFS
> +L:	linux-xfs@vger.kernel.org
> +S:	Supported
> +F:	common/dump
> +F:	common/fuzzy
> +F:	common/inject
> +F:	common/populate
> +F:	common/repair
> +F:	common/xfs
> +F:	tests/xfs/
> +
>  ALL
>  M:	Zorro Lang <zlang@kernel.org>
>  L:	fstests@vger.kernel.org
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
