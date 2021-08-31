Return-Path: <SRS0=+lo7=NW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF634C432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Aug 2021 16:24:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1D0610CB;
	Tue, 31 Aug 2021 16:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E1D0610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mL6YS-0003KY-59; Tue, 31 Aug 2021 16:24:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <djwong@kernel.org>) id 1mL6YQ-0003KO-Ni
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 16:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0R/Bd0/GkBWtglrzQz/JuCu0RSYjhWmYKY6JTGSzWc=; b=ScagUae3/PEk3aVSuue5Qd3/B9
 ay+NlDMApww2At8EkQPLbNzRTIftWly2RyzVIiyvfHUaaCDCf/M/Oe5BpCTGd6PPKqlqAyr8QPgq0
 BrX+wQIc0g3ys8o5w/7IZXD5cxs/fVxHNK1FQOjoAMsGBMxVhoogU0vBjbPozDPyS0Ug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y0R/Bd0/GkBWtglrzQz/JuCu0RSYjhWmYKY6JTGSzWc=; b=m
 B01zhnFAyKCINMh/ptOH94zdCy5Puov7g528DNKNEIB3kChzuncWqs+T4r+rnXAeXMGU+KJpOqY2d
 W/nt6gF04qP1W8Rp8Wkb0I73AUAZzUtLWEz1afoKhzYX2eeKjkMVnTgZM9jfEg02B4E2vurEDmaoA
 rwfSS2XBDqTX/sT8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mL6YQ-009Dwz-7r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 16:24:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD886610CC;
 Tue, 31 Aug 2021 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630427036;
 bh=3CBp1rvnjRLq+ik6Z1JLX8BGifdRSVjyPCQ/sJLco80=;
 h=Date:From:To:Cc:Subject:From;
 b=GJDt8FZiuX6BwPq8ZneIBQYR7/55jsZG3CALHsYjMPVq62nclr45gyns+NNlAa8Qq
 tnSATmOv1NJ9M+ylEXUMCGciXq5sWAQX3qXP6SO6VsImSo3KAAh/8V3YLRd6efOylv
 TBNZU3nIi9Xk94jVOmVqByqQ8nOiWAVqXgEu3e0t4VnTa6M46N8nzidH7sDzGxlnun
 TTGkZicia1PDQA+cECjev18ns/N1BhkJATV7IlUkK5m/VFQ1W5Rh39+vTzR2WbVxSQ
 7dPlBOIE3YAY6M+R6iG2Jqgv2ToDR8g15q+YgogsjBR2rSEhP4Us6nqGi9yv+2Q0Nn
 NMlL3Y+mRJeMg==
Date: Tue, 31 Aug 2021 09:23:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20210831162355.GA9959@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1mL6YQ-009Dwz-7r
Subject: [f2fs-dev] [GIT PULL] vfs: new code for 5.15
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
Cc: Wang Shilong <wshilong@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Linus,

Please pull this single VFS patch that prevents userspace from setting
project quota ids on files that the VFS considers invalid.

This branch merges cleanly against your upstream branch as of a few
minutes ago, and does not introduce any fstests regressions for ext4 or
xfs.

--D

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.15-merge-1

for you to fetch changes up to d03ef4daf33a33da8d7c397102fff8ae87d04a93:

  fs: forbid invalid project ID (2021-08-03 09:48:04 -0700)

----------------------------------------------------------------
New code for 5.15:
 - Strengthen parameter checking for project quota ids.

----------------------------------------------------------------
Wang Shilong (1):
      fs: forbid invalid project ID

 fs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
