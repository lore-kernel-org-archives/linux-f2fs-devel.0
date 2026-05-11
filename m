Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664C4CD37BE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuwNx/PyuX1E8njWCubtUhQAikx+EDBwKrqvf2O2EHM=; b=A/xY2NcCkVEiF2rJvwi4AYH/cd
	UYNrBBDDVBR/xVg/fCZtN7sVcumPQtmr37oxfjxCdyf1HAtPt2BJCMNl5HpgA9X2IoQQ2c61VIWRD
	M45Tgo2GOZ0vfyOdZilG+X90Oza3Y+2fv6Cns2+rmZhFwgnWCp2qzw96QG1V5kBhGxKU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMRK8-0008At-PO;
	Mon, 11 May 2026 14:09:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wMRK6-0008Al-Qu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 14:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RgTi2HyJCaLeMiU8Fz6KzxgFZeGWAYkpKt4i7qk5j/Y=; b=JLzYhttpDg4j+61weOkCacoJxx
 zQDHXgmpZu3IthPO8yi1srAXl6AtFAarsMDcJ+5HVCOfX/LGxenmICUWWzTJIXlEDU/8K3u0krgM3
 ZWystlcu+zOOWWJhAGZti77ARJ3YoJ8ZK2RH3beXBEkQ1CzVOVuf1N13sas/TVmLAJa8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RgTi2HyJCaLeMiU8Fz6KzxgFZeGWAYkpKt4i7qk5j/Y=; b=HcdU8cU2siY7IeyGzIFduHn/yF
 w4hfp/ukQnpYi27Rw+yag0qlqdWRlfvE82kM2+bE1RTZ+UoBzQzpF7Z8tW1HMQwxj/ky9+pc11Sqe
 iZWfheHkU4m/RTKoDHgimjoVFd0l4lFlQxZCZLJGDfzHSUEsOsdkxjaUHfHb5lvm00+k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMRK2-00031T-Rt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 14:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B81E043E8F;
 Mon, 11 May 2026 14:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C9C2BCC9;
 Mon, 11 May 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778508181;
 bh=RgTi2HyJCaLeMiU8Fz6KzxgFZeGWAYkpKt4i7qk5j/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qHh6BeNVXR5vm2TUiXQsksN3VWXztHJjQkFUZMOC+Qda/fWEMcns/JjxLR3zxNEF8
 RW0LUH87ebCxHlpBnjBEVZ4eYSBHU4SYUwgBJCjBf8Oy9rdsZ6jiuKrkH4PhwjeWk+
 pe416YP5BjHKZ6H49uqVf0DOF3Oe+9zXQF0ovomTWTQ1O058SCn8LVYT9gf3zbHgNW
 1tItZO73KnbZttQj67r7+SUNkYvwl10aiIUwOq17sqCObXi6e5mT3HSiViqfG4oHS3
 I3+ifllP0AIc51Xw+F4Pn3DQNxAwmqb99mPNsRgVCLfqrI/k4HWqH+BGQHyUBSJQFn
 RPDIjjlkL5JEw==
Date: Mon, 11 May 2026 16:02:50 +0200
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260511-verhielt-osten-3fbfde3e491f@brauner>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
X-Headers-End: 1wMRK2-00031T-Rt
Subject: Re: [f2fs-dev] [PATCH v14 00/15] Exposing case folding behavior
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, Steve French <stfrench@microsoft.com>,
 sprasad@microsoft.com, frank.li@vivo.com, Al Viro <viro@zeniv.linux.org.uk>,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 07, 2026 at 04:52:53AM -0400, Chuck Lever wrote:
> Christian, let's lock this one in. I will post subsequent changes
> as delta patches.

Perfect!


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
