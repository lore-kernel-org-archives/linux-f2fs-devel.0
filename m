Return-Path: <SRS0=nB2U=U7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79DAC06510
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:45:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780112089C;
	Tue,  2 Jul 2019 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fTolBnXC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WGxs6fw5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdVby+/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780112089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiGI6-0001SB-8b; Tue, 02 Jul 2019 10:45:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <amir73il@gmail.com>) id 1hiGI3-0001S1-LV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 10:45:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vlidC+hQ/gD/8v9eleM4nXtfiap8zhCG0j5qbLCVw18=; b=fTolBnXCZgspQHHrw9xlzf9Sat
 0prFUUtg0CTXpPodnSYnjOusBbPDSs1r0de8/6caRdae9n7Kn3XyPCZCfKDK2brpKu/sNHZqTR/M2
 Zbsm50hxCkChjpcGN4Qhd9aWLFKjk9dX/1m0wZ3RZCwyCuC4oIYQKweRv8SvzEQm8Kz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vlidC+hQ/gD/8v9eleM4nXtfiap8zhCG0j5qbLCVw18=; b=WGxs6fw5gxtQkIGiRyvMSEOGWq
 c/5ZjO/gPs6U9hJ6shQPqAYBz49DWJ4VEapt5H0J3IQ1IpHOF9zS6kuVVDqZwboD8wnplngB9z7m4
 9zrFDdFKpHBVHdN31PdmYUgGA8dVmIgWkQUwSeJw2z9cTS6aNvx2nB0WnTtdsX1VUnKo=;
Received: from mail-yb1-f193.google.com ([209.85.219.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hiGIH-004nhF-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 10:45:51 +0000
Received: by mail-yb1-f193.google.com with SMTP id a14so1119832ybm.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 02 Jul 2019 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vlidC+hQ/gD/8v9eleM4nXtfiap8zhCG0j5qbLCVw18=;
 b=kdVby+/PzZu5i6Y9UcQYatHEHHsEPhAQY+mjVHF6xlggt8o+nszbdHXCHfEBil5H5H
 UL+/28eYKfUAOv8AvNzRMQHWK/y4MABFSamQhRwNZH1hpEc5BUQCjqITvhev6DLWRzG3
 uOgpinFcBt7pSePpbwiWspS3cbj7dBXMod+4Z94YngJ+nIPc3qdhbsYftXAC3oBGhakE
 Bt+6iCjbrfqQEg0SzB1WdrzlyuHEb0JfhuYdop7KFU8fbo4QPvOCj4+Z+NVkWFYsg5RT
 IRHHoit1jxeDZWaJHULPmpdSPTutxwczS9nSE3h7MYk2MPhM/kHniCv9ovLGXWy3LfTv
 lmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vlidC+hQ/gD/8v9eleM4nXtfiap8zhCG0j5qbLCVw18=;
 b=VFQ+YpHotkNULb+/sHF+O4ooFqXA+TX79MAT06sBB48AeORic9sTOl10OY6S80RMeN
 njWCa4OzuSD2cuOPiPqK/BT7XpgK+rBtt3Mv9BBq5+SjUHkLhUzfOeqYpUfbSuwsK8QG
 yo9NFAKmBD+61xO74kU0oar0OKi25IhrLk3x0Uz5IrlOtjSRQ+tLJ/dIQWgoZTmeYZiP
 rs7KNrK6McUUPGvuThGqRr8w/G5RivkTCh3VPR0pvPI/U1gkW1Xb0vS0MINKHgsHU4BC
 aNDetOJxtpPS6N0XQAwjXgoeI8C30VKFyzCGyLRBHKLtefaMTSFGsu6QJPS5KZ1lNTua
 pvhg==
X-Gm-Message-State: APjAAAUyEMNmUUHL01/uCxsdGIByQeMCn6pMO7gXuiq35GfCgEyJWho7
 ePz+BfE4vU5Wo6FoJEVzdhWR8fydwrPZ6iLKK4E=
X-Google-Smtp-Source: APXvYqzMdrjXgWGhi/zPaZxEj+t8DhHrW56qP/YMhmryxOT2o02rqdhc3hQ5y4gjPvsnd8KwypjTK3Tgmn2Zfydvxjo=
X-Received: by 2002:a25:8109:: with SMTP id o9mr16913558ybk.132.1562064343920; 
 Tue, 02 Jul 2019 03:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <156174687561.1557469.7505651950825460767.stgit@magnolia>
 <156174690758.1557469.9258105121276292687.stgit@magnolia>
 <20190701154200.GK1404256@magnolia>
In-Reply-To: <20190701154200.GK1404256@magnolia>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Jul 2019 13:45:32 +0300
Message-ID: <CAOQ4uxizFXgSa4KzkwxmoPAvpiENg=y0=fsxEC1PkCX5J1ybag@mail.gmail.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
X-Headers-End: 1hiGIH-004nhF-Uc
Subject: Re: [f2fs-dev] [PATCH v2 4/4] vfs: don't allow most setxattr to
 immutable files
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
Cc: linux-efi@vger.kernel.org, Linux Btrfs <linux-btrfs@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, matthew.garrett@nebula.com,
 linux-nilfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Ext4 <linux-ext4@vger.kernel.org>, devel@lists.orangefs.org,
 Josef Bacik <josef@toxicpanda.com>, reiserfs-devel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Tso <tytso@mit.edu>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs <linux-xfs@vger.kernel.org>,
 jk@ozlabs.org, Jan Kara <jack@suse.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 1, 2019 at 7:31 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> From: Darrick J. Wong <darrick.wong@oracle.com>
>
> The chattr manpage has this to say about immutable files:
>
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
>
> However, we don't actually check the immutable flag in the setattr code,
> which means that we can update inode flags and project ids and extent
> size hints on supposedly immutable files.  Therefore, reject setflags
> and fssetxattr calls on an immutable file if the file is immutable and
> will remain that way.
>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v2: use memcmp instead of open coding a bunch of checks


Thanks,

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  fs/inode.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index cf07378e5731..31f694e405fe 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2214,6 +2214,14 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
>             !capable(CAP_LINUX_IMMUTABLE))
>                 return -EPERM;
>
> +       /*
> +        * We aren't allowed to change any other flags if the immutable flag is
> +        * already set and is not being unset.
> +        */
> +       if ((oldflags & FS_IMMUTABLE_FL) && (flags & FS_IMMUTABLE_FL) &&
> +           oldflags != flags)
> +               return -EPERM;
> +
>         /*
>          * Now that we're done checking the new flags, flush all pending IO and
>          * dirty mappings before setting S_IMMUTABLE on an inode via
> @@ -2284,6 +2292,15 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
>             !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>                 return -EINVAL;
>
> +       /*
> +        * We aren't allowed to change any fields if the immutable flag is
> +        * already set and is not being unset.
> +        */
> +       if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
> +           (fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
> +           memcmp(fa, old_fa, offsetof(struct fsxattr, fsx_pad)))
> +               return -EPERM;
> +
>         /* Extent size hints of zero turn off the flags. */
>         if (fa->fsx_extsize == 0)
>                 fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
