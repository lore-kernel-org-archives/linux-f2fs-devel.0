Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B707CD13DE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2026 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4KS89st08GXXsLjV/p8QPoCpTuNtxgQMqSvBbJbCO4=; b=YOyjJ4MapvlXgMaKKTGtN6jFGT
	hNuOK8WtftAkZ51uoOz0+CTr9FyF+rnGBuYWBqd0A84zGVqrfWl6tgYCjXg2VrIEL9nVXtlSJxcTt
	FJ+ejjA8BrhP2XZK3wO0N9sRyeTEMubJAn8Kb5pDtfBZfxDYgzPuoz5nOG8M52sU2F6I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIc8F-0000RI-FU;
	Fri, 01 May 2026 00:53:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1wIc8D-0000RA-BO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 00:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KzQTclZuCoJfZ2MNb+MG5u6QR+eoQTmWjD0e6rKq0Qw=; b=YX2m4I1UDoAsw40QCEbvXQWVoQ
 xWprhqO4m+q+wxhHf6lgjkOP0M0Zqn+oCAWJegqmOiyUJ8/uT8qsI5kcWnovefH6qATnrZi1Qs9vM
 VIQMNolkJzp9CWg1p1lhSJUK9GLiwZtXny1ETZdl4qnfPzItF2QOgjGL9T5D8xJNlO1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KzQTclZuCoJfZ2MNb+MG5u6QR+eoQTmWjD0e6rKq0Qw=; b=hi2+ll6v/H0vyTqDg5hY72AEc7
 P8k+X31Kd4ecm3QhLIf38FVqBc5Le38nZf13I8cEvUNBRqtEMB840xjaPWsS0oDq7OGpmkjPshCFO
 Da+sTB/F1Rslzazq+RaZgPNX0nugY6cGlOroWQVC2mK/PPKzhqt4VI/nIJvrQG/yuriA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIc8D-0003iw-0E for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 May 2026 00:53:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0678440EC;
 Fri,  1 May 2026 00:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA5EC2BCB3;
 Fri,  1 May 2026 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777596799;
 bh=KzQTclZuCoJfZ2MNb+MG5u6QR+eoQTmWjD0e6rKq0Qw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GlJD0K60kmdn1mNAXeHnhfZsjneL3nGCWYf7I/ZdXgzyzXQJiekK1lMzcW87+hydS
 GoiCqTdA74XmXhhW+iC0cBGCE8BaWJiGzYNravm2WFtfEpI/MClfEujZDcqvC81R6O
 Q3KmaylAZtD1v9RUDf1OAYzGj5piq+8YRmHjE68bqcsQMJAfuGV5lkir8KfKKn8E4H
 EMBkRqcOK562uwtlI1/4uF7az0QV2TIBJ4Uvr07vNVOb+4NeFToXgKhU+uUH2H1eca
 PgJ8cnlEAUM69P+ObisYRWX1WWuBmLzQ9NQj3ZWG1EsET19jcyHKf/dzvxZsJzyiua
 xS+W7g+nCYBLw==
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Date: Thu, 30 Apr 2026 20:53:17 -0400
Message-ID: <20260430160000.item006-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430054510.2001015-1-rob_garcia@163.com>
References: <20260430054510.2001015-1-rob_garcia@163.com>
MIME-Version: 1.0
X-Headers-End: 1wIc8D-0003iw-0E
Subject: Re: [f2fs-dev] [PATCH 6.6.y] f2fs: fix to detect potential
 corrupted nid in free_nid_list
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Robert Garcia <rob_garcia@163.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 30, 2026 at 01:45:10PM +0800, Robert Garcia wrote:
> From: Chao Yu <chao@kernel.org>
>
> [ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]
>
> As reported, on-disk footer.ino and footer.nid is the same and
> out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
> any potential corruption in free_nid_list.

Thanks, queued for 6.6.y.

--
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
