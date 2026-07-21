Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA520C44520
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 01:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=81Xf7jtakTNzWB+359LKII+c1R1frD479c6Qny2BVNk=; b=OpfxJAUUbyqoNac2S4ku9uRRHq
	gy7qL4uWTG68bIuf2kHpIzBkJnaFOJchekZHLrSNw2BJkTjfou+T/DDO+ZxAlItXM823iZOBF94qs
	DXV5a23m/+gfxMft05v4dLYpd1D6KJu33K52gyMTb4R4qeo9uaHxdN3w7gfzezUKCKyQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlzim-0002cl-0R;
	Tue, 21 Jul 2026 01:56:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wlzij-0002cd-R6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 01:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xjg3PltNc1sYo38Zt2iNop90gKX5rxaYlYtNB7NQOZw=; b=gnuTgcuHEmU8ag8LPs+eokm7oB
 lGN0oL+syDNIFVR9BCgSfqoYYW0QmLeOz0lUP3+R0RhzSf2NjpvbXkUC7t7OP1vV+L7z+yBwLQpEQ
 E8+HLAoyL7YdNCknT4gu9XwNv7xbMx6Yscm3b9aEIPvEPvVV4xfmn5mxJLW2gq/qc8+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xjg3PltNc1sYo38Zt2iNop90gKX5rxaYlYtNB7NQOZw=; b=h8RbHRPUKqNTg/RBXhr/WtB6JG
 UP42kavzGHrTwWRwGJfcYqTIKchZKA/u/2ZLut7DG3KDZrZAhbFYcSxVqNTULcgv3aPSFADiu1uDO
 Fuxh5LUS4cSJrf2uKZc7dnnnJIEd5Ojx7tp/tvRZrNL38Cl18RhV+qomHRqvkCva9Sdw=;
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlzig-0005cF-Ih for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 01:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784598978; bh=Xjg3PltNc1sYo38Zt2iNop90gKX5rxaYlYtNB7NQOZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ewHIhLpYv4hIhy0WZ7vHLbY1zWmc0uZ4iYdlNrePiGvG87NBI8TuGOlLjC0x1teva
 tS4pWkd3xlcERpO5rV15eA0QMg1TwPMCPBnzJQRDUUqUbD5G681rmli0K81EAgANjw
 ib3fyqeVZqYiQHaMoS4JzIDTYSpdX2CJX8iQoYD4=
Received: from ikun ([36.152.24.184])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id E0F11C76; Tue, 21 Jul 2026 09:56:15 +0800
X-QQ-mid: xmsmtpt1784598975tme3lhrsm
Message-ID: <tencent_12223006930A92674051D2B32F64DACD0105@qq.com>
X-QQ-XMAILINFO: NMiAo2azIaDADUCoZuXWUMbRJo6tpQ6oNGQRHxrbqz20rsNCGJStcjUqC0Qhvk
 Rrbk7lnZs+l4x1373gVr8d6ISJkUulurkKgvqJlQR9NtkG46XaGtUyzlXHwF+rX+EhJRznufkrCy
 CQg9lkvKkG8rf0kapjiwoeyrpZA7IYUBkuGgL6u38sqiuO2MgylhoETEPbADAtjpgGa25bzCN299
 Oie8cN2+inD+wmoJtTwQUuagbFrlL/fubouKxeXgch7zYVp3wd69jl1tHhouvQKvCJJsOfy7uOGG
 eo6bI9nEvo8oCMntfumE7tpdVuE4ieXqtUE3WEx/T6Jx/AG5oCYaYfrrk4SzO6s82NQUhTVaPqdk
 TPR4MhVNJHdr+2Ndiv089TkHt0KB95KXm2b//FT6YGKdR+4oIWYXhZwo3KqdbLZuJaPu+SZaZQGX
 wzXj1QhezyD70MGZSUky7bzQxRSsBf5j2MEbSge7aZOSV7f4gM76yu7iq7gfWvxIZlWMhqqfs/2Q
 dv9x+TbwUi64nGHDVOUQfKQ1sWQXDcKJHw0jcAMnXWuyOpezHXbiwqiksBfSVdX50itfwNs7POpz
 3vcHDLCGBux/SFxiOUcp7Q3mxjtX5g3EeDPcZpWTvBfPDDBEhXNsj3/GojbJmKEmR20jmraORnuB
 HG6vEo17vdTGdwghbBHnrhegAmvyAVfM0//KLfVl3CJ+lAg5h9Ybfa23VT8gwsnfsQ58kk/dbL//
 g3vOJ2nqpUtmdwxSF0RSKKVufAyGfnC/wEyD9EVkVxWMIX3fU01Ue8PesptgQTaQ5k7f0ndMoDVC
 W40pe9gFmJJrLuV3RPlwZhdpH9/P3IbRAXZvhpZHIRLzWGbTG5FIEyEfd4JnYqPjpdKW/BpeksZJ
 MvyznDpE1XgXW3f9ne4klhFwmIdInWU8YaN0Sjk/FNXps0LT6u8ih9f3Ma1tbk/QmPKpeYgW7jDT
 mJ9cuMDkqpmxccnsIXoY3cnmQP7Jfcs3Ua4Dt4yMRen1sh8i0gJ8P2bnW1FUctJurYwwTzPayyaf
 KTbSlBFn8N1KTs3lkvSFexYLap3MA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
To: chao@kernel.org
Date: Tue, 21 Jul 2026 09:56:01 +0800
X-OQ-MSGID: <20260721015601.624-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <b3a3d74c-338d-422f-b2c7-84ad00a9187d@kernel.org>
References: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
 <tencent_2D9E7B21C16E6E10F2315454333C5E8A4D08@qq.com>
 <b3a3d74c-338d-422f-b2c7-84ad00a9187d@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wlzig-0005cF-Ih
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in
 f2fs_move_inline_dirents
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: jaegeuk@kernel.org, Guanghui Yang <3497809730@qq.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

You are right. I misread the condition.

When err is non-zero, f2fs_put_dnode() is called regardless of need_put,
so dn.inode_folio is released on the f2fs_reserve_block() error path.
The caller only releases ifolio on success because the error cleanup has
already been handled here.

Please ignore this patch. Sorry for the confusion.

Thanks,
Guanghui



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
