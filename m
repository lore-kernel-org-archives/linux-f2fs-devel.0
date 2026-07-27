Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5147EC531D0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZ60oBpKQhVoSczdwCONUrywMNK4T39wdpLYLNIyd6s=; b=MEhMl240aXzA2QmbDfsKGBcFSj
	DDIeaQFAX+PoLijMO58Y3pe8L9vR9cpnX0b0w64drMlS5+6Jnl+U0I8K1ImOmy9MJH7FXvIAVh1H1
	m2iUCHKdBJdMMgHXy6FPMkoIKRuPfdVqigjCMkGJ0mZne9krzkj3CjsSclkXtb2Hkgv4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woJgs-0001wH-Tn;
	Mon, 27 Jul 2026 11:40:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1woJgr-0001w5-Iz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 11:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=; b=eZts0070hcC4AFySm2DDJ+WS8h
 Qbu03jpoPhUVdE3EF0RjGlkbtjDbbpDUp/6AgC8hAPV+wKbyqlDwdK1vgyCgkqIBtqIzoutqIzLaS
 gPWzaLaUh4yB5F7gAjrnUeyvRcnQKbBiLhv85m7FSDRBT17y+ENXe6Lo0tSFcLo9uejM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=; b=QQku4TfZZ6bMGllWR+W2dNt74Q
 KU9u9aPy1abzE8SQtUaqJ71iYBHLlcj/pnfQXT85oxW7L41cIV3QSPKNgMoTxbBoJd2KXe9ft9eO/
 GfmD2CGHLYnxswpJOKOZH5ZkAQzzq0hcuH9xslyNXgL4tu4M9nK0KP/Ggo+GUOMcQgbo=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woJgr-0003ZF-RA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 11:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785152407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=;
 b=gtDOBZUpRFdw2prYrCHvHS0Dw+CmRDMjpfFU7GRo3cm/6NGZNhpZS6AUKsKr9BoX8yWciu
 89CoJoSy2J6HsYnOm9EHJOu04A6tBohlaAYSDJG769jDR/N+pdral9RQhDY83XoEUq/tHb
 hr+Zu0O6gQhfuk7O1rqZR3xlvup3ei8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-NsrnIizAPdyBX2FGbLJd9Q-1; Mon, 27 Jul 2026 07:40:04 -0400
X-MC-Unique: NsrnIizAPdyBX2FGbLJd9Q-1
X-Mimecast-MFC-AGG-ID: NsrnIizAPdyBX2FGbLJd9Q_1785152403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955d314945so18737865e9.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 04:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785152403; x=1785757203;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XjT/PIWbG/51hlsr95HE/1iGTwI0BlJqCQFAOLtkIYs=;
 b=WQSbVrPH1jqcYdZh8jgJjGUPVzVx7CnpZ6MTvklRqov3bJMwOlJA60CeGHSsyBgmiC
 bAE6QuDojiwL/Ln7rJA3gzR85YmBFJDsGZaHfJBvKXi26q+XcK/EfKA6LdmKTn1dj4zZ
 QwyyBbohN16IEirDwoxy04BcIU2dN/nXN+ClsruH3t4KjHYoJ21kV8wRt127rS2bomcM
 agV0ykWpZ7sV/Rws6IgJuyyPZn0kHqjk//aB9s04F3pxdffFZtCa9xs21FX1wOq8K2fb
 l1ufoEQyaqxVv+YOxbgHhybwDMBbXG1cxWmAaHxncKo2XaUOcxKsYEuqKTRXg3reMI8o
 I2NA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk2GIhupI62m3u3UqK+VnzwLR/DWAZ5UMD9M1CDk2DEGRHzv3IdMmcr2HfwJMb8WbRUfGtmpgejgZ4Rg7Etlai@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwhGfirykztMJDqc1Xso9H93K9F/eqlix4rbhCfam1xwgX3rOD4
 M8T1OUzNt2L6ngTRhbGjy4k1h1oznPAaxVyscLZ7wSknVNwKvmsvQI/HknRs4mDSqqWidbC0+Ey
 H0G8VymuUs6fjb4PuZaZqYOBcH9BM72G1php18Wg4e2YD3xT486F+ChYiYa00ulhvoPUefj0pfg
 UthA==
X-Gm-Gg: AR+sD10JCOGcrnNkhdPtte0VpXfJHktkahx9QOMg06wxvwFwfNABMH68hvRu0+gRxwH
 FOkjKlGyis/XzFRSDcJiArMVutLtTDoTDPl3GQDIyVmeYsMPhdXHJc+/WVlcVmuBN/Yd1rkjO0Y
 bLK2Lm1Hv2O2so95c6xNp0FQxTGPDHZlX466dJPuZX5eSWDgLK2h8wQI/SeuQVyvXmyVkMaEo5Z
 Ps/ZxwQjMHMAQk6FIpUAwLX3lYrwdDCRUN+/sNXEUx9sPG5ecOCkPY8gciskegrYA1JSgwEJ7je
 8NjjNID1Sy27Vgm4w24o6zT7i5ImYQEjHaTM5Mo7rjSmYP8Re5eflIXT2T0vadYc7cHOFEIH2Ae
 Ypf+9Etl4zXfeS3D2Ucs3syxRNW7WGcYu7fQ=
X-Received: by 2002:a05:600c:c87:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-496b5747df9mr103190415e9.25.1785152402902; 
 Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
X-Received: by 2002:a05:600c:c87:b0:493:fa66:4861 with SMTP id
 5b1f17b1804b1-496b5747df9mr103189935e9.25.1785152402345; 
 Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b499ccb4sm225617015e9.10.2026.07.27.04.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 04:40:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 13:40:01 +0200
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <amcy2KC3veaniXof@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-3-aalbersh@kernel.org>
 <20260724233744.GB1901@sol>
MIME-Version: 1.0
In-Reply-To: <20260724233744.GB1901@sol>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xaWjJjrXK__Fe4iFkAI5Zqnt4cDwwwbFJf7Nca5wxtg_1785152403
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1woJgr-0003ZF-RA
Subject: Re: [f2fs-dev] [PATCH v13 02/23] fsverity: expose
 ensure_fsverity_info()
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-07-24 16:37:44, Eric Biggers wrote:
> On Tue, Jul 21, 2026 at 08:40:39PM +0200, Andrey Albershteyn wrote:
> > +/**
> > + * fsverity_ensure_verity_info() - cache verity info if it's not already cached
> > + * @inode: the inode for which verity info should be cached
> > + *
> > + * Ensure this inode has verity info attached to it, it's assumed the inode
> > + * already has fsverity enabled. Read fsverity descriptor and creates verity
> > + * based on that.
> > + *
> > + * This needs to be called at least once before any of the inode's data
> > + * can be verified (and thus read at all) or the inode's fsverity digest
> > + * retrieved.  fsverity_file_open() calls this already, which handles
> > + * normal file accesses.  If a filesystem does any internal (i.e. not
> > + * associated with a file descriptor) reads of the file's data or
> > + * fsverity digest, it must call this explicitly before doing so.
> > + *
> > + * Return: 0 on success, -errno on failure
> > + */
> > +int fsverity_ensure_verity_info(struct inode *inode)
> 
> There really should be a note here that if the file is also encrypted,
> then the encryption key has to have been set up first.  This was already
> gotten wrong when it was proposed for overlayfs to call this.

Sure I will add a note.

> Do we also need a more specific contract than "-errno on failure"?  The
> caller in xchk_inode_setup_verity() tries to distinguish between
> "metadata validation errors" and "runtime errors" by checking for a
> bunch of different error codes, and I'm not sure what that means
> exactly.

The scrub checks that if incore fsverity flag is set on the inode
we should be able to read verity info. If metadata is invalid,
"metadata validation error" happens, then scrub will clear fsverity
flag on incore and on-disk inode.

Not sure if this can be improved much, any new error codes won't
trigger scrub. Passing int *corrupted everywhere also doesn't seem
to help and changing everything to EFSCORRUPTED will change
file_open return code.

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
