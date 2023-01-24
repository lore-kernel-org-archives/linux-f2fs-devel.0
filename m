Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B18C54EED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Jan 2023 22:19:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pKRdP-0006hN-MG;
	Tue, 24 Jan 2023 22:19:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pKRdO-0006hH-Gd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jan 2023 22:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U85zQgZaGptirm1FMFBd9riQ9xroftiQcp0//6ql7pM=; b=lGf41KmCceAno4DnDjn1TadHE8
 tNucMEHjptdfloqUJNNQUForGGQELoPTca47rUmcY87SmuYr6VMt3GmURDv1U3QfKyrSRU0i7wb4Q
 hZNjYQtSZxlZXHh7Ol1YiKtN2UTWSvGjpn+NnXLn6YA/yV8xJcX86S+OOpLkhg4GLG8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U85zQgZaGptirm1FMFBd9riQ9xroftiQcp0//6ql7pM=; b=k
 8/2G5x4nF/wQyhUret8UIDq1ML3HhIQGGuakrpC64JgEcUSBzrOxBK9HhFBKm723EfrE0MDeRuflw
 luOyYQppUFykFn6Dwb9AVzPZqWcAYbp65Mh2xxqs5LvFTdUWjV0rM12sD2Vzl24Suam04o/Ol7euc
 0XXwA659bhmemjA8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pKRdN-0000s0-1Z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jan 2023 22:19:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 67CA961356
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Jan 2023 22:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885CEC433EF;
 Tue, 24 Jan 2023 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674598745;
 bh=U85zQgZaGptirm1FMFBd9riQ9xroftiQcp0//6ql7pM=;
 h=Date:From:To:Cc:Subject:From;
 b=RJLaBl7HvSbm+MpCR+0mN3BK9lHqfNpQTw8LhfL1+E/zYND/9VH6iOA02F+whWIYT
 MBO+1bzKu/HqapvdzmN/o/Ln0c61wWzjMwcs0hBCjpYZVFEdi0RCglOICthtf56fvx
 gsGAdIaYeglG//fL6OR9ZLiP+CRRvY23GEKvp5OVlQ9K4MpT4du9fNVJSvKLb9QzJT
 xZIO9mbNqRoSwh0ptq2Vu2xwAeb/qC4XIhZca9hDKFGq6g0AcyZ7pM2OuUoZ12ogTt
 ihOYq7FR+sb7apou6uuKQ0aD6B+cxZmj5t7gxDR/cc1Y+8KeT2K3oJUYJe+FG0Q+Gt
 YIyg4+k6E/iwQ==
Date: Tue, 24 Jan 2023 14:19:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Message-ID: <Y9BZVw01GbP6T3XY@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1pKRdN-0000s0-1Z
Subject: [f2fs-dev] [ANNOUNCE] New mailing list for fsverity development
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

fsverity development (both the kernel part and fsverity-utils) is now using the
mailing list fsverity@lists.linux.dev instead of linux-fscrypt@vger.kernel.org.
linux-fscrypt@vger.kernel.org is now for fscrypt only.

When sending any fsverity-related patches, please always include the new list.

If you're interested, please also subscribe to the new list by sending an email
to fsverity+subscribe@lists.linux.dev.

The new list is being archived at https://lore.kernel.org/fsverity/.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
