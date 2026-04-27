Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129A4FF8860
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iu7PirnVbYPuBwzVOuQkk4wHlnRP/VGQ8SWcyM4t5SU=; b=Wh8IB1+akaZdBRwg8mk3WqlE4K
	IZigud4UtIL2kXLlaieFQVdfgckFrX6aJ1NXi5bDMXy1BRkudVdO4hAZNvSVjMiBkLpEfgGqxQuKK
	49QHipemEm+FIuktkyEv78tV/L86A7Smdy5OPD4WZUlmZDoeuJoCRUSJ+5f+f4/TMtKI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHKfl-00082B-C5;
	Mon, 27 Apr 2026 12:02:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lionelcons1972@gmail.com>) id 1wHKfh-00081W-Lg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 12:02:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=; b=fyC8YDRxkSKHEe96QFcWK7Gxm+
 M3pvbPwblymofkeclDBpiwBQzDgknCyT0oT4V8WHVTm1dKiOjrzhU2uz/29DG1STus3f0XUmBEd6f
 XIuRUTE+6cNHoeoJTn5kzFdbKAfTROrkg/Msxt1EFCydkgCtxRqdLbTGgOmpfy0JJZiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=; b=ksoKM7Bg5f3gJoh/gTnY3gHDBe
 skCOotGbcSSXTymFEyB1h5pvu+tn7ea0nsqaGNmIIU++2eyncyqNiX/4CAAyjjvzexFeIgtmjZ5BZ
 g5ujd0eA/uUaEiXN37A8Gw+cyZw2fggGdpQhegCQeiHWjHy2p65r0CGmTO0+qiYrBSxg=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wHKfb-00044O-P3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 12:02:37 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-66b2d49ffb0so12911608a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Apr 2026 05:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777291339; cv=none;
 d=google.com; s=arc-20240605;
 b=BhyI4wfR6h/mIvZsMzFwK2uvF79roWL8sjLrpNP3cEZ6PCRxacs5QoNoFAYpBB60sb
 oviKojTGekLJ0J88d06aBRIBwwJKLvrqv6H2kxeJZBeXSRuev+fm4vuyl60CtE3sMZUv
 Bx4+kKs+tKVs4MX4xFoVhzbNN3nYxwaQtOTbWQQySfQK+f0+Xp75njWC1Vo5fNZiSw7n
 T7K4XmKfp2ebnW0EMugdt/wmBR+vZvqAmzv9ogEp/7onYLljyCEW5ALgfCBD7L0RPUJX
 zbN62E28pVEOb+XV06zgkuPdgUnZ2EB+QkVsnLZXjfV9uh3WtMKg5ReFHpLJe8yntoIV
 H7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
 fh=jKUqHfKi/xxmBZ/m6oU2ZoQC5qUpKfEkso3zprPS9iA=;
 b=aK/bi6iWsEVo33rX/sS+SIEJX2DfawyW7Bi0cXHk8I15CRKS81ATZ+2ctvCa3nqm9o
 S31rnb/SEH3dR611rciMmtnyFJqWUxDH2VfTKwOkLzZd7TE1B4+cTB13uXCu/1DdylAf
 wGigAp4tjTg3pPzhjhwGGRFzeHqS7KcQtb2PtK5dlylmV8FThzCYVPqTyeIlDBlz6bYQ
 Yrqx8BJoIQvC+LQFrRh7Dw0HOC60vNFBRHJmTxq2PcQ75lYfo+pP1NUPr3SD9Tb+IVzJ
 FQEXnqiKFrHqeBiU6Xzt0I3SuUsPVVLiCLgYrIJqMOtAs7AziJ4RoLAvrl6dF58Ai3VR
 sz4w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777291339; x=1777896139; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
 b=n03R5jjsZyBFS1Vglrn4psgtddp9GmP6YjdeOwuKRzcNmiGDLSm4H2RBZRx3YcuRKr
 OskM2a5rnmUoP6vMCVnmE7y3DqITBXKDBWEGI1ETLug4w5F5/N7483qxzOz1LPNQ4vsl
 Sn92nbuOQYDNG0O183vvPDsf+QAgFlKH7a2S/XhvVEfWuZgExme5KKSlQAIpUMP2dFVf
 BRNFxpPWGNEy7Dgcfi6cMIptWbgqfI0NkzTfsHgPC1B4KGXeGViDy0MsCawxD56+bv6o
 ywpeIORBRKcBPEwCw3qi/3OhkdxnuFtDOsBOq14BrmY3VqNatbn/SnyPn5uv7JC8Fg/X
 qeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291339; x=1777896139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSw1aMO32TuHJYbNOmDfdqPOAHdqlsV6G0A1b+WUvMY=;
 b=JRBrwtb1BccmJAOTbeTT9sdW7Ugvr4qo7OUH8qGLF4gTShDdEh9FPeImqDbcX3V2fL
 XYOjxgBnHnit8RCsnPl9zO+6TWrynYA3TezcEkpIkOgvE9tLkZflG7reVRL98vC5RoA3
 pNlMl90FlxtFKIV/emPoXlJF/MOB9f9jvLzIceotTdioszmJMDtbfldOUanbm5GgIweD
 53Xa1XCR48P1xvq0TpoEPhIDvwN+Y+GF1SrK4J21nzXb/SfEdtskhY+SY8odJijLYr87
 9Q1Pht8crhp4BoVu8Vri8KOXufmIMVyE4Sq+Olr9aS2VkVbkuK3napnrUSW+HcwVeQge
 1Q2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ghYBrvYBH4Norp8n3R1Rnqh5yIG6D/9TWzXaXni6XP8UBJryj+gXJRJl8N3c7l5mXUaMRpZEV6f1gjz84TB4t@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwaD3k6boVFPfuUwk/XECbGu9ZmK116/YFA0IdiTaW33N3tByn6
 KYPbDc8QpqndZ1Li2ag8p6dm/8NV3EDeyy2MbLvKgG0Mp7x4jymlIE0RG89tar0L/go47GR98Ar
 0Ry/ngWIFXC8idQ+o099g5HAAJjFBYg8=
X-Gm-Gg: AeBDietRL51+BVgQjTCyLZVixpcxiVx0J4kNIOkCdLO8dn3b4Fokvg0VWgYhSBW5Bml
 tMkXvnkS6is6MXFPRM6uFCG5es1tVPj/KoC/+LDm1G8z5ldQfE95bocB6NCVNGVmn7Jh8qEUpFF
 VrlTLTK9p2dFhvOFF17uAv1IvVgcUpC6HtoeaWEG87KyFlcpbu09t0AX2Lb0NCuqPol7ihNP8G0
 RwqNoXSDxEAS/rE0/r6cBxqI9MD648UXIEZTuYnFwWwblHISi7WQmtNYEBugu89z/G03zP8tLeG
 aS16lPReoUwuLtKwygjqkYjIN9TB
X-Received: by 2002:a05:6402:c46:b0:670:d548:da79 with SMTP id
 4fb4d7f45d1cf-672bfd87175mr18491070a12.3.1777291337998; Mon, 27 Apr 2026
 05:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-12-de5619beddaf@oracle.com>
 <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
In-Reply-To: <isfgwmd5hxjfn7dj7p54yzlhumx2hrkt3zw7fscs2ywm57g3hu@co27drpx24lq>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 27 Apr 2026 14:02:00 +0200
X-Gm-Features: AVHnY4JzeOH_kK3jDOjK2FxeQTqZ9zkWJjZAaa-9jIyvUG0bleb4vaJ230stvGc
Message-ID: <CAPJSo4WmRu_64TxBsaimWOqz3VAU0TZ1H-_hw36HSqzQULm39w@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Headers-End: 1wHKfb-00044O-P3
Subject: Re: [f2fs-dev] [PATCH v11 12/15] isofs: Implement fileattr_get for
 case sensitivity
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
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Chuck Lever <cel@kernel.org>, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 27 Apr 2026 at 12:47, Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 21:53:14, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Upper layers such as NFSD need a way to query whether a
> > filesystem handles filenames in a case-sensitive manner so
> > they can provide correct semantics to remote clients. Without
> > this information, NFS exports of ISO 9660 filesystems cannot
> > advertise their filename case behavior.
> >
> > Implement isofs_fileattr_get() to report ISO 9660 case handling
> > behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
> > mount option enables case-insensitive lookups, and this setting
> > determines the value reported. By default, Joliet extensions
> > operate in relaxed mode while plain ISO 9660 uses strict
> > (case-sensitive) mode. All ISO 9660 variants are case-preserving,
> > meaning filenames are stored exactly as they appear on the disc.
> >
> > Case handling is a superblock-wide property, so the callback
> > must report the same value for every inode type. Regular files
> > previously had no inode_operations; introduce
> > isofs_file_inode_operations to carry the callback. Symlinks
> > previously shared page_symlink_inode_operations; introduce
> > isofs_symlink_inode_operations, which wires page_get_link
> > alongside the callback, so that fileattr queries on a symlink
> > reach the isofs implementation instead of returning
> > -ENOIOCTLCMD. The flag is set in both fa->fsx_xflags and
> > fa->flags so FS_IOC_FSGETXATTR and FS_IOC_GETFLAGS agree.
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>
> ...
>
> > @@ -281,6 +293,18 @@ const struct file_operations isofs_dir_operations =
> >  const struct inode_operations isofs_dir_inode_operations =
> >  {
> >       .lookup = isofs_lookup,
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_file_inode_operations =
> > +{
> > +     .fileattr_get = isofs_fileattr_get,
> > +};
> > +
> > +const struct inode_operations isofs_symlink_inode_operations =
> > +{
> > +     .get_link = page_get_link,
> > +     .fileattr_get = isofs_fileattr_get,
> >  };
>
> Hum, I thought casefolding is a directory attribute. At least I don't see
> a big point in reporting it for regular files or symlinks (and then why not
> report it for device nodes or named pipes?). So why did you decide for this
> change?

Where do you see this being a per-directory attribute in
https://web.archive.org/web/20170404043745/http://www.ymi.com/ymi/sites/default/files/pdf/Rockridge.pdf

Lionel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
