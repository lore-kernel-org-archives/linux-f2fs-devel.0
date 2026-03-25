Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087BA109C028
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1/0lTNGabcHkVWiMN1y4Vrjb18AvMWkK7Rch+ZrIOU=; b=ZNfIW9a28BcKpEAnL7HrxawaJ0
	uv8agG48Wo4vFFf66GvoYFQpMuUpUwrd4KI72yBTjmZeZsWD9V7Ma78zNLK2Od6OeLCco1V6D/eZS
	r3OiNU+PHBXzmR2sbMTB37hLDVzmRai1xVAkKlKlGPfzdsTW76+iISqyo2NZ2uYl59Pc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5PvU-0006J8-Mo;
	Wed, 25 Mar 2026 15:13:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5PvQ-0006Is-5o
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rNL6GJd5Q5tmhNn8On5YLiKnN15MDWCklKjJxCXufAM=; b=AvTMQbhdifVdeaZZ7UaoVK4SkZ
 1uXrvQF+4ZCTXQdD/wMHQnDG79JycpFVjuRxwdhLl8AG/0xmBmxqMuTAO+wjRoX5P1+eavOKFKwLa
 Di7ddPFRbd9x/pB6ChSHETeTTCBvrXdPUnm2ma4bTMw3Y5ZNTdRUvar0ZLaqBs4UWtrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rNL6GJd5Q5tmhNn8On5YLiKnN15MDWCklKjJxCXufAM=; b=kIr2dzz63/traPN+YqWWpoSEZp
 sJpFHZRQoiWoHbPK3dZR7O05E/Av9VD7gChwC+ejjfTv+xuA9dAYlCbYXubRcj8CcYH5BeaEDZ9+j
 Bk57uhfJW0JRofgIMXwKWyAopf+NNCh0Tx8SJHZ5C2f6YK4oDbUV0HVhq7a0rJuW7SLI=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5PvO-0007l6-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:13:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC4C968D12; Wed, 25 Mar 2026 09:06:41 +0100 (CET)
Date: Wed, 25 Mar 2026 09:06:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325080641.GL952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-16-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-16-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5PvO-0007l6-B3
Subject: Re: [f2fs-dev] [PATCH v5 15/25] xfs: disable direct read path for
 fs-verity files
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 19, 2026 at 06:02:02PM +0100, Andrey Albershteyn wrote:
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
