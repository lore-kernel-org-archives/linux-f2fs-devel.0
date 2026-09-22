Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E74C982FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Re8ZCmZ8tTUAtKJk8vMp+q2vE/gChaRADWZlAv33xjY=; b=Ns+lnzbmwEDciu9EmgLA6e3EQ0
	YdG1iZX6ULJEIbiGo7XtZR/YyxMJtlz4hQhBNrdBk+YYI2fjxZrafMejqSDkUmmvrPl5WkR/CiSLA
	WIz+HvOe+YksrhJyRPM4uvULaeQiTOTIqVv1JqSKeqV1kuNf6ZnuAlmx161jsmfvAe5o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8sTv-0007os-AF;
	Tue, 22 Sep 2026 04:51:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1x8sTu-0007om-Kq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dvwaJCeY0gmtqMzqdDkr35DZ3sIjv+2fswWUP3+256Y=; b=IcWjsf7No/G765y8ov4xd5RbOb
 MofVdOC6evnPa84lwV+V8LoNpR4H/gRgpJOZ59yeERP4eNAqKq1yl232IDGBR5xcwMlFi7dmK8B50
 +TJ4wchKZtNfoVZjCzd7AfP+zh0yGTylD2YpJaiCNo0v0PHyzqNearu6fvqoM7UvcWIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dvwaJCeY0gmtqMzqdDkr35DZ3sIjv+2fswWUP3+256Y=; b=i83yDlxm3ZIQEA2tBEoLuOd42G
 1Fy+psFry8ehuokyv3ULIK/tg5P2KGR5qiLS/dgoASZmr+Hz/ZSykGXdJQg+30T7wOSWtIoLKSX2t
 OenyTzSFXs+ytLr2bJyNGlBLgLtnXHN8aMfr4dUnmSBez1mtnfesTizp+bl+iGBZwakM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8sTu-0000mA-V0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 04:51:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 4D0BE600CB;
 Tue, 22 Sep 2026 04:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A84EE1F000FF;
 Tue, 22 Sep 2026 04:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790052704;
 bh=dvwaJCeY0gmtqMzqdDkr35DZ3sIjv+2fswWUP3+256Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fp3DdgfRyZNLyBzjGXgtZ3zhDjwjFOOQ+F/qrwrqqIdokCm2a8Ot8XN+Erjb/NJSY
 ttFwUSrqBJ7h2c2GRbAbEZcE/ozz/rzzMiD6FGSJBiyCaYl3Vg5urEqbSR0JhIw4sS
 HV2evyuD2vKCW04G59GAsaOkMycmaC3lPW+IS3unCHIwDm2I8HRoJqj1rABWGLNDvv
 rDJJaWZd2FMZi/jNuQGeuO/2W2BWhfd4fkvE6SRNHsnKwe/GWMEIbnfyXU+cB2A+uO
 bfpiT36NWsZCH0ub5KbUPkUpIexuSPGPbgFXtdC3c3LTvhqfgeXJTSNqZWwhB6hw/o
 12w0IYlur0T5g==
Date: Mon, 21 Sep 2026 21:51:44 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260922045144.GP2705364@frogsfrogsfrogs>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
X-Headers-End: 1x8sTu-0000mA-V0
Subject: Re: [f2fs-dev] [PATCH v16 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:12PM +0200, Andrey Albershteyn wrote:
> Hi all,
> 
> This is next revision of fsverity for XFS.
> 
> The main change from v15 is addion of kmem cache
> xfs_fsverity_ioend_cache instead of adding work_struct to iomap's ioend
> struct.

FWIW, Sashiko found at least one or two bugs, but the reports only got
echoed to the ext4 list.  Perhaps it's time to discuss allowing it to
email linux-xfs for bugs that it claims to have found in xfs code?

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
