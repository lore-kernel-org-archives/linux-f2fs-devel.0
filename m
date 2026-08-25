Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E62C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RlVwWxBLQlmG581y6c5YoyvpiTqawLt07NJD4FtAs+M=; b=GvorgLRLJEBtjdqDX//H2wA+hA
	zRMm3ukGCar25WREnhoSsyV2/TjuV5JfCVefngbSRPrDzKRILVbo4t4JxxAiN7rxrwisROp4t3fhl
	Qm/co9iAAwHVwKEfgjdWwdGNnHmzCRVuy5/vb/ONpzDk97jzy5U5gKvH3R3zwnDYBM38=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wytGs-00061v-5c;
	Tue, 25 Aug 2026 15:41:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wytGq-00061o-OU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jdS2eCnDxAey12FpiL8OC3G40xXoovct4KAJ4o/k/rY=; b=WZQz8oGTqL+1EOQa2yZu+dgcsI
 zxgL9cvFQNKQrr2rW1iPNJIfPfbgP4U0MNfIIyF+wpC+ekVyQ4Hv13IUEvtbOCgrciU2NQn6E+di0
 Ki9OK8D7b1yrzxYa+FKOaPb61kb2EgPHriSVpVGIVJC9Xhq0kO95+jFP0Am7ENkhhrcA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jdS2eCnDxAey12FpiL8OC3G40xXoovct4KAJ4o/k/rY=; b=K
 9k9MPzFYMZb8lOEAm18skeYvcPg+XhQeXBHkQTtd+eqNobfHeNlsG4V7i3FLlNWrb40SfHRTVM2l9
 UavB+FelDtArDFtSVNzjdJ1q+Db2tVN2MawpU/oOVjdY8i1K//5NWWpY1DqoDp9QaSOXSmePGmgKb
 kh4pIJGGGOaFqVJo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wytGo-00024k-VE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AF18601E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038FE1F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787672457;
 bh=jdS2eCnDxAey12FpiL8OC3G40xXoovct4KAJ4o/k/rY=;
 h=Subject:From:Date:To;
 b=UXW3AIWj8EJ5LymIQ95bDNEZn+i2uNyFf3eVYnZqKCLNsIudB+vr7DbWU9zoI8EK+
 SGknxiHDkUDLx95zgh3MacUa/2+EUMMqYFdhi8szTX1teefGSe8OpKQAnUI6jR7JcT
 xhCnnk5kM8OUqcv7R+KilYidwNstt/LcrKxnKQ44NjYiVKI9PuxhqzcfwqYw5mo/cH
 GVbwZ6/GwmujJGurbrrAmNVQmV9KYhPRkmtlwYkWMWSXOoq1k0sGBZleikuHbl32PF
 3Ie2fnV2paJIVlhIwYB6y3jbIrV+4U9ge2UGuqyzEJAghvlG/bXu7gxWsSSxgCmEMT
 sUErd8vH5O9YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1C3AA3924FEE for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:40:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178767240366.3943858.17945327487666238540.git-patchwork-summary@kernel.org>
Date: Tue, 25 Aug 2026 15:40:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wytGo-00024k-VE
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,v2] f2fs: use adjusted write range after f2fs_write_checks()
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1150560
  Lore link: https://lore.kernel.org/r/20260824023231.24616-1-jsjlee1020@gmail.com

Patch: [f2fs-dev] f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1150917
  Lore link: https://lore.kernel.org/r/20260824131729.3694378-1-chao@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
