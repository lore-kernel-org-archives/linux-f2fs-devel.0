Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7B4C4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/TRCVs7s+I1dU4vbVHYsL891ZBmuGYPOdGYW3Yww/U=; b=eKN5WZjnLqrf6XwsTsVKhgR9x0
	aX+qQc2g8/NgkoXVmAlfeB0rQg7jiebUedyXeYEZFCYt//auuZOzL8juwPjoacospwoIjDly1004r
	vLZ2qEs/QzqdUpPsqup89eH00UZ3Z7gaYftKBjtW5nBi5TbggvOv3U/M+rjo73xGd2+E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJqf-0003n6-Ev;
	Tue, 21 Jul 2026 23:26:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wmJqd-0003mh-3m
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PShLnoDa/Diacqu8FRfVhJ48Cf46bFdlZ3c0z+aO0xE=; b=Am9ptYuDy0zkAYFo7ANvheOSkm
 xmEzaZkNxKBHsmTRlWgGzXOkXO2RLKeOX3uT/B4CNhz9/CCX59SR51ttbqJUD9WxN9RXyGfHev4Qs
 DTc62ch7mK0bD7pzHf2TcGQG4n6g3ID2KP5Zjn29wOeJSAalwUrMR3hmrCRMoEQHu62g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PShLnoDa/Diacqu8FRfVhJ48Cf46bFdlZ3c0z+aO0xE=; b=b92kM+sK41/nMaPXVOq2Z2WiJO
 YGI6PEHTSgFGDVPXJkDorI+OoKOmUrYg0eCMEuQr+IvIXzFqNMXM8g6ncDrk5e1hL6/IR+eeKTc7n
 Wr0gZ/Qu+5m+VACRDe7aB3rbuLRcPP2ggqRwHJAGi6NfWGKkK3gHz0H6z/P17siOkMgM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJqa-0005mr-8a for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:26:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 9685D40A95;
 Tue, 21 Jul 2026 23:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 67A981F000E9;
 Tue, 21 Jul 2026 23:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784676349;
 bh=PShLnoDa/Diacqu8FRfVhJ48Cf46bFdlZ3c0z+aO0xE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f1AtmymN0KKxYQZ5C3Ji/is5GsAWWp7NB5QBUVi8Es75mtRQTvFZK3rNiC3yCPkQQ
 tpg1CslKLMO6jI7jrGlASb1dpbg85F0YrbtFkYxCQWob+NcaS7bUijnZGlMMD985/8
 AJefso5AsWY+ADoy+APqsUwS9KFZSB20WIhoI4Av3oyYTd5xp53gJDPiHM66SaVAlO
 EWFIEsZJsN3SciJ9gp3i0cQaZkxUpLteaBsio1r1arGbNlRUORAU//pU9Z2L77+MXg
 YIGxz/cSJs2yVKP7ipp9qmdYsd3M3PgCycyl46oa5zOJGjLgIZ39Iz1ighy0GMT7Ps
 z7Ch9KAxAEG8Q==
Date: Tue, 21 Jul 2026 16:25:48 -0700
To: Anand Suveer Jain <asj@kernel.org>
Message-ID: <20260721232548.GU7398@frogsfrogsfrogs>
References: <cover.1781694879.git.asj@kernel.org>
 <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
 <20260701173314.GH6517@frogsfrogsfrogs>
 <328de723-6f9c-4f09-a68a-da24d49300d5@kernel.org>
 <20260721225703.GZ7380@frogsfrogsfrogs>
 <18d569b9-dbea-448c-8b3d-56de32c0d6ef@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18d569b9-dbea-448c-8b3d-56de32c0d6ef@kernel.org>
X-Headers-End: 1wmJqa-0005mr-8a
Subject: Re: [f2fs-dev] [PATCH v7 06/11] fstests: verify f_fsid for cloned
 filesystems
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
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 22, 2026 at 07:21:15AM +0800, Anand Suveer Jain wrote:
> 
> 
> >>> just in case there *are* programs foolish enough to
> >>> use (fsid,ino) as a uniqueness check.
> >>
> >> On the other hand, if a program needs a unique ID, do we currently have
> >> any way to get one?
> > 
> > I don't think there is a way to get a globally unique identifier for a
> > filesystem image except for the meta_uuid filesystems, and even then
> > only if the volume manager resets the user-visible uuid every time it
> > makes a clone and nobody runs a duplicator.
> 
> Yeah, interesting problem to solve though.
> Do you have any further code review comments on this test case?

Not really, no.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
