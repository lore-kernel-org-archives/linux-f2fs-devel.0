Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A8EC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzbnYZAWeo85KsQPxUanABTjnJETuiTF5P3N5/jbUes=; b=mPqZSsxb1lPVHcxXHE0IUp7LIB
	0bA/nt6dMB9TH2GVULVabqrzSlbxRCsgZU6SeTHCO4S8mZDTBuvxnNR/e0vPFMd9QGYZaOKnBesvG
	ubILXN/3kRFuJtCN4AoiB74Kz0QJLG29UbSvqhhRFVMUmy38MGbolxNX9oqO7Dlsr3/A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr29v-0003Oh-Gi;
	Mon, 03 Aug 2026 23:33:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wr29u-0003OW-KY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 23:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uQ4lduqTGbaAGqVmz0m6IiMATE54BovOr9IQtRWkjk4=; b=VMBtgFSxnXVbXI/s0jzShWpxXN
 7O5QzDp3L5LJUcipHghgZdXdwZEH8L2mDMecEnFNqKe4pd9Z1B7u5VOKwOQtASqE9xen3wbegv3bQ
 r9V0qpNhWdAgMSzIt9LbmeVxBTthMzRa3WDBQhyr1o8DrVDdw4EfypAfbHcdDj6WtBls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uQ4lduqTGbaAGqVmz0m6IiMATE54BovOr9IQtRWkjk4=; b=BPKtln8h/53foLJLisVS1cHjEY
 JTohYvaTAXyD6pb1kvtWRV4WOwQ5Au26MMFJVnl0X4mSIIaDugKzDpmdpwKhEXNFNxunD8en2udV2
 VVTciAcCfTC3Wmk5JMT+WD0RG9JXFPRB3zPujidb5XaG6A63HofepfW3d0PLQVVERr7I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr29u-0000xp-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 23:33:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D89960A60;
 Mon,  3 Aug 2026 23:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916701F000E9;
 Mon,  3 Aug 2026 23:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785800000;
 bh=uQ4lduqTGbaAGqVmz0m6IiMATE54BovOr9IQtRWkjk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=A8NJ+iDtMvOGhYSOi1+g0IZHr8Oy/RfbhD8Gg38HFJByHK1yGKs/vfv53cHHzm/eO
 8ud4Aei8G8A/VJt2c4+dtnVUGmTG2G4nnsiZ+smqUnuK0LhYhOO9QGXwieEe0yrcFY
 679X987Oy5LOWmXg8JIf4WczHHWasaApyEcOR7zuqgsdKkZyzMoaITrRhm+LuexRNe
 Ip31rhqrIjTDPGDt9Tny469TIAQzDkVQoDuv3ehwTKzExZ1Hgops74Olo5DMkf9oKh
 cBAr4soDPoE+mHsDz/NFd88/WX+NXxaMcgXqO+n8Tc9VsJomS/oIV6nQZKZ0YEwoWh
 UKQvvpRSv7tJQ==
Date: Mon, 3 Aug 2026 23:33:19 +0000
To: Christian Brauner <brauner@kernel.org>
Message-ID: <anElP9djtLESAgWF@google.com>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
 <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730-jargon-tauchen-angehalten-d4e97dde0ebe@brauner>
X-Headers-End: 1wr29u-0000xp-P6
Subject: Re: [f2fs-dev] [PATCH] f2fs: use the mount idmap for the owner
 check in f2fs_xattr_advise_set()
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Rochan Avlur <rochan.avlur@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/30, Christian Brauner via Linux-f2fs-devel wrote:
> Hi Rochan,
> 
> > f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> > &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> > the idmap that was passed into the handler.
> > 
> > Since f2fs supports idmapped mounts, this compares the caller's fsuid
> > against the unmapped on-disk owner rather than the mapped owner; resulting
> > in the actual owner to be wrongly denied with -EPERM. Use the idmap
> > argument that was already passed to the xattr handler instead.
> > 
> > Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
> 
> Seems generally fine to me,
> Acked-by: Christian Brauner (Amutable) <braurg>

Thanks, let me applied Acked-by: to the first submitted patch, which is same.

> 
> -- 
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
