Return-Path: <SRS0=iK4e=E4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9929C63697
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2020 05:13:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3A22078D
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2020 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GCvVyqwv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Vz21UACv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNX7N2c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3A22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kghgM-0002uB-S8; Sun, 22 Nov 2020 05:13:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hsiangkao@redhat.com>) id 1kghgK-0002tu-40
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Nov 2020 05:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kkf8a6qy5yhhSG9mvfioRD8ySsdwKXfzz3BkGnvDRY4=; b=GCvVyqwvhQA49UGFh9OizSNHdA
 q+j66zBfNHcEWeUYEMJsWWbDStnMaY0TPGanu7XX66AcusUanr2NXPLCT3Go8LufX/cey+BCv5Hah
 d1+A3Frol8eVLR2vQog5fVhGUT4pFZraKd2UKCiG0NCeokRDm8eyWAalV4ps779OWz/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kkf8a6qy5yhhSG9mvfioRD8ySsdwKXfzz3BkGnvDRY4=; b=Vz21UACvHJK0huSdUSlnYhQqOT
 MfGsjnVoXtO5ue2SJhlYrTLEmrmZ5DH3BL1K13Xw6CO71QvegH0ckf+P7us/Q16BI9L1tDADqxEZJ
 G2Qf/XPVbmc/NjeoxqxRmtAd9SX0lnaIivrkhaNBgr+OMDIVitjX7MWhFJ1EgZuZheg8=;
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.92.2)
 id 1kghgB-007Ts3-Qx
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Nov 2020 05:13:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606021958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkf8a6qy5yhhSG9mvfioRD8ySsdwKXfzz3BkGnvDRY4=;
 b=LNX7N2c6WjQeuGNKPFqXgYx78pr1YQDkbmySPne2IYAj6zJ8omkhZ7tIMwZgy4fnw7Iszc
 /+z+dhbP966WtRX90uW1YqG3ucn1F6k9CEAKPWGNevtQxhctn8xA2pg1AgdaisHBXq27bt
 yJyhIn3JiFwKsNndIg3OUp6E7oFL20g=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-aUKjR9mHOMuojT6V7opWZQ-1; Sun, 22 Nov 2020 00:12:34 -0500
X-MC-Unique: aUKjR9mHOMuojT6V7opWZQ-1
Received: by mail-pg1-f200.google.com with SMTP id g3so9404462pgj.20
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2020 21:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kkf8a6qy5yhhSG9mvfioRD8ySsdwKXfzz3BkGnvDRY4=;
 b=hMhcMH+T7s1aGehmEIajC6IJDK7E3VKxTX0Fi+iIo15czAxbOs/jDTCKL7gX4q58KW
 56UHWtePu0rX167JpJWB6n3Aa+jhEWIiqvNBcl5f9ZzIH5E+nfDzAoCY+1Q5FyAsdMCd
 JewI5kAEG7nf1WMFUAjmR+4/Tlop3m/axiHnVNyBeyx358u3Im4V6lhsERtfRLYWqrnR
 N5jYsg+Hr0nRP8hikAFfEgr+9ppNEfSgRLl5Lbn0RjfArMS+B0ClOw2f/9sQYlanu1Bu
 V/AC1vpjrYblxsI9cz8Wje2UFetub0hCOIqqWsSSlmVtaiH6KijZZuUwwUSUrpS/LLCm
 nndw==
X-Gm-Message-State: AOAM530U8wYirN6/+WiI0u15T6dDmq1gy8+YBjK/AYujBgPpt8jzC8uP
 FpRYaDpAjAJxblqpQwSO+5Qz0JCVK52tFxx2pJdmiOmJw4f/zyup6yzy2VslGimvcVCGo2H6Iyd
 xiSSR85DMrV5kbidP4W1o3/5gLXmcrrZBRNDfWg==
X-Received: by 2002:a63:4513:: with SMTP id s19mr22764167pga.254.1606021953658; 
 Sat, 21 Nov 2020 21:12:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhkBDDpVzvwVvP6QvR7b7bk5JCtZ4ytNenw2ZosC6tbrjTUa7xakgrk4oLyDhCHqqDiw3bXw==
X-Received: by 2002:a63:4513:: with SMTP id s19mr22764154pga.254.1606021953454; 
 Sat, 21 Nov 2020 21:12:33 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b21sm9346038pji.24.2020.11.21.21.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2020 21:12:33 -0800 (PST)
Date: Sun, 22 Nov 2020 13:12:18 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <20201122051218.GA2717478@xiangao.remote.csb>
References: <20201119060904.463807-1-drosen@google.com>
 <20201119060904.463807-3-drosen@google.com>
MIME-Version: 1.0
In-Reply-To: <20201119060904.463807-3-drosen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1kghgB-007Ts3-Qx
Subject: Re: [f2fs-dev] [PATCH v4 2/3] fscrypt: Have filesystems handle
 their d_ops
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
Cc: kernel-team@android.com, "Theodore Y . Ts'o" <tytso@mit.edu>,
 Eric Biggers <ebiggers@google.com>, Richard Weinberger <richard@nod.at>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

On Thu, Nov 19, 2020 at 06:09:03AM +0000, Daniel Rosenberg wrote:
> This shifts the responsibility of setting up dentry operations from
> fscrypt to the individual filesystems, allowing them to have their own
> operations while still setting fscrypt's d_revalidate as appropriate.
> 
> Most filesystems can just use generic_set_encrypted_ci_d_ops, unless
> they have their own specific dentry operations as well. That operation
> will set the minimal d_ops required under the circumstances.
> 
> Since the fscrypt d_ops are set later on, we must set all d_ops there,
> since we cannot adjust those later on. This should not result in any
> change in behavior.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Acked-by: Eric Biggers <ebiggers@google.com>
> ---

...

>  extern const struct file_operations ext4_dir_operations;
>  
> -#ifdef CONFIG_UNICODE
> -extern const struct dentry_operations ext4_dentry_ops;
> -#endif
> -
>  /* file.c */
>  extern const struct inode_operations ext4_file_inode_operations;
>  extern const struct file_operations ext4_file_operations;
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 33509266f5a0..12a417ff5648 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1614,6 +1614,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
>  	struct buffer_head *bh;
>  
>  	err = ext4_fname_prepare_lookup(dir, dentry, &fname);
> +	generic_set_encrypted_ci_d_ops(dentry);

One thing might be worth noticing is that currently overlayfs might
not work properly when dentry->d_sb->s_encoding is set even only some
subdirs are CI-enabled but the others not, see generic_set_encrypted_ci_d_ops(),
ovl_mount_dir_noesc => ovl_dentry_weird()

For more details, see:
https://android-review.googlesource.com/c/device/linaro/hikey/+/1483316/2#message-2e1f6ab0010a3e35e7d8effea73f60341f84ee4d

Just found it by chance (and not sure if it's vital for now), and
a kind reminder about this.

Thanks,
Gao Xiang



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
