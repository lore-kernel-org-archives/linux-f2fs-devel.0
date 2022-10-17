Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FA6C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 08:31:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okLXC-0000iI-2x;
	Mon, 17 Oct 2022 08:31:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dvyukov@google.com>) id 1okLWs-0000hx-Ty
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 08:31:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=; b=gIHkvPMsS3Bo/I3VyhyHb7jKWh
 ULGDLy/Il7OgEDt4WnqPAPU0BDbn7wZwzl2jxC4DBsFW7wtfznBkjEPk+KU6Svd98IoxXSft3fpBH
 JxCnMgkU7JfOH9qTym5NbvKQq1tET6bWvqxOAvUZITgs3C8QvDX53jc1je+HVCKTYZkc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=; b=aRWH2nbSSIHo5wTxGb1QN1p0DL
 5oCh4CNmA0MTdipxgxLX1G3vi8/5qatm1HcdP/72QmMrEKPOpgYWcjsPatVgjOUzmZvgqDZdI+mYm
 9LWqntxMzFccbl2IfZ3cJP3k6Paq3vk6PlyPvmvVGNh71WdqKag1lN+K66NhTYOH/6tk=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okLWs-006j8d-9P for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 08:31:22 +0000
Received: by mail-lf1-f44.google.com with SMTP id s20so16332552lfi.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=;
 b=iXrGdd8Ce/D/Ym1P/AKmDjhkCRodIz0sVHqhCXCbzz/70S2w/xiwhFMs2ZE6LzAOaY
 kerpA8DKLp8h2EYJv/OamQ96cNwCdVwhlMsEt2I/Fx1TXldfIxx8y8EdnjfTih1j5QQY
 mcontV8hQeGs5ML1x0iwjYx4oVH0ravWrBbKL8nhqpsejuYizWkrN/Z0xocIgE9V/nqA
 /ibMQ5BBiN6XVdPz/bWMDfcoSg3yAyVOTjHlVwPDjsYICQVyEKqxZha6l63hzWMq89fQ
 ikDz03AXZbI54WZYRpIVuo0JGyUqwrFqZ1lSI9F+0vgKA6aqXG/1CN3roD6DwyasNLJq
 0f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8KsRspEgB/gOfpXeMit48jsmBa9u2K7sMr+wCGZ90pU=;
 b=GB/OpCcCxSEorWamgpFrMs+X8o4/m+wgTRWi2NDrkB7vvxK6CX/eo67yk1CEcNT3A0
 dA5UERYaMIpy73O+bi1C+wegrghZWShkaRmTAkPK/tYtGqWqMRMK7NsG5eWwRYd2OskW
 3QKhKongr3QhbCQ4puBRHyclkDt5NSVOJ0vKRL5yEjDHcLLinMh2kj7bZGsWdX7LazBh
 By9PmiddC3d6kwVyevOqlvizpUlGcOtUBhxM2WuLyHIlR6I0G2T2qG6S8AS9zLBZzUm/
 JscsMajCT3wdy3xuGI/P8qLwGFNzRaBROTE23dpQdxQc/NmlIDqlHCFlVQenqA5BMylr
 2mMg==
X-Gm-Message-State: ACrzQf0uyugp3HXkG5WF0v0iOro3c86eSMSlj9hMX51JijtnwUEb1VYP
 IlvwxV/BDgY3bPzY9ZkJejssZmrI62w7RqmTEXy6VQ==
X-Google-Smtp-Source: AMsMyM4vtxZKfG1BBKlWVvUdtQPv/C1LzAh0hWbLTBbJjcAgFk5XHPxnZIEqc8SnpuZmZ0z0x8oPZB51ly6T8M4BxPI=
X-Received: by 2002:a05:6512:358c:b0:4a2:9c55:c63c with SMTP id
 m12-20020a056512358c00b004a29c55c63cmr3765865lfr.598.1665995475449; Mon, 17
 Oct 2022 01:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
 <20221014091503.GA13389@twin.jikos.cz>
In-Reply-To: <20221014091503.GA13389@twin.jikos.cz>
Date: Mon, 17 Oct 2022 10:31:03 +0200
Message-ID: <CACT4Y+as3SA6C_QFLSeb5JYY30O1oGAh-FVMLCS2NrNahycSoQ@mail.gmail.com>
To: dsterba@suse.cz
X-Headers-End: 1okLWs-006j8d-9P
Subject: Re: [f2fs-dev] [PATCH RFC 0/7] fs: Debug config option to disable
 filesystem checksum verification for fuzzing
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
From: Dmitry Vyukov via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Dmitry Vyukov <dvyukov@google.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Hrutvik Kanabar <hrutvik@google.com>, kasan-dev@googlegroups.com,
 Hrutvik Kanabar <hrkanabar@gmail.com>, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Marco Elver <elver@google.com>,
 Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Anton Altaparmakov <anton@tuxera.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Aleksandr Nogikh <nogikh@google.com>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, 14 Oct 2022 at 11:15, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Oct 14, 2022 at 08:48:30AM +0000, Hrutvik Kanabar wrote:
> > From: Hrutvik Kanabar <hrutvik@google.com>
> >
> > Fuzzing is a proven technique to discover exploitable bugs in the Linux
> > kernel. But fuzzing filesystems is tricky: highly structured disk images
> > use redundant checksums to verify data integrity. Therefore,
> > randomly-mutated images are quickly rejected as corrupt, testing only
> > error-handling code effectively.
> >
> > The Janus [1] and Hydra [2] projects probe filesystem code deeply by
> > correcting checksums after mutation. But their ad-hoc
> > checksum-correcting code supports only a few filesystems, and it is
> > difficult to support new ones - requiring significant duplication of
> > filesystem logic which must also be kept in sync with upstream changes.
> > Corrected checksums cannot be guaranteed to be valid, and reusing this
> > code across different fuzzing frameworks is non-trivial.
> >
> > Instead, this RFC suggests a config option:
> > `DISABLE_FS_CSUM_VERIFICATION`. When it is enabled, all filesystems
> > should bypass redundant checksum verification, proceeding as if
> > checksums are valid. Setting of checksums should be unaffected. Mutated
> > images will no longer be rejected due to invalid checksums, allowing
> > testing of deeper code paths. Though some filesystems implement their
> > own flags to disable some checksums, this option should instead disable
> > all checksums for all filesystems uniformly. Critically, any bugs found
> > remain reproducible on production systems: redundant checksums in
> > mutated images can be fixed up to satisfy verification.
> >
> > The patches below suggest a potential implementation for a few
> > filesystems, though we may have missed some checksums. The option
> > requires `DEBUG_KERNEL` and is not intended for production systems.
> >
> > The first user of the option would be syzbot. We ran preliminary local
> > syzkaller tests to compare behaviour with and without these patches.
> > With the patches, we found a 19% increase in coverage, as well as many
> > new crash types and increases in the total number of crashes:
>
> I think the build-time option inflexible, but I see the point when
> you're testing several filesystems that it's one place to set up the
> environment. Alternatively I suggest to add sysfs knob available in
> debuging builds to enable/disable checksum verification per filesystem.

Hi David,

What usage scenarios do you have in mind for runtime changing of this option?
I see this option intended only for very narrow use cases which
require a specially built kernel in a number of other ways (lots of
which are not tunable at runtime, e.g. debugging configs).

> As this may not fit to other filesystems I don't suggest to do that for
> all but I am willing to do that for btrfs, with eventual extension to
> the config option you propose. The increased fuzzing coverage would be
> good to have.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
