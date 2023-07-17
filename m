Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01DC04FDF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 15:20:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLQ1T-0001zi-1Y;
	Mon, 17 Jul 2023 15:20:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qLQ1P-0001zZ-1b
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 15:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/TmVX/QSghn4tnH6KdH6PiuCli10EM54eYf0vFBI8mQ=; b=GmaLUs/P6zDThiweOIdl9NR1YL
 /IklKvLhGQWZ0zHcbarmuA5QazvrX/C8aie3ULKfTYPmWVMCFvbUEF7KwztPpCkMh+u1DqugpI0BQ
 e5hpZVUu3ViEmbMpwsBU9ATpAS+Gp9vhW/k6dts8hX42Fp4b3/ABwqoCjdswwi/Hut6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/TmVX/QSghn4tnH6KdH6PiuCli10EM54eYf0vFBI8mQ=; b=fJFuDf3B+IB5xIGLNp27ZM1Mvm
 BZGd5EHce6PzeUeZLJ1z0/ynxIxghT88ggyzydUkPtCx+MPME4+TyECTFJzIUwzmQQfC31rYKQS8u
 mp84suA5w4lxPQqS/HYBtFb8FisNdnpcnj/pxrsK1CnKkOdqvQOAbqZKUiRu/bEhDpYs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLQ1O-00Ai6d-GG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 15:20:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB6676111D;
 Mon, 17 Jul 2023 15:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599CFC433C9;
 Mon, 17 Jul 2023 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689607214;
 bh=pmHa+uof/omh9/YyLI+lAkXG8CFJh+ryKNfzwo+yCiI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GnyILK+xYovKsbVfNzoWkm9663M6Mcp18LctpBhc0uHXIV9W0VXk8z1f5UTmiT0K3
 gUCuh3yzYqQSxpq55sY9cl8sAsBRxL6y4QWuy+U9Sfhc+cdj5Nyxr+Reud7F9V0Omw
 z5Yc68k6zZSinDmsBlmELbjXozXBtsd7RRt3XOg6yJpgKCuSf6EuGm47o5+ORNweJV
 yEGs7xbyn82Zve0ght6k6L0rHslTw38opZ5O8gQ3sD1p9aktjqXzaJ2/qLDq/kW5Jk
 fl3smMa9rSGLDntzLfiJFqp67kp2DdBmXvxx/MVj8INpzhwDuqFSPruU+BQUcu+Qd8
 +QUmiX+WqOBKw==
Message-ID: <e42cbeb5-e890-c8b7-f1f2-1cc04a340edc@kernel.org>
Date: Mon, 17 Jul 2023 23:20:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Minjie Du <duminjie@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20230717071109.5663-1-duminjie@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230717071109.5663-1-duminjie@vivo.com>
X-Headers-End: 1qLQ1O-00Ai6d-GG
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: increase usage of
 folio_next_index() helper
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
Cc: opensource.kernel@vivo.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/7/17 15:11, Minjie Du wrote:
> Simplify code pattern of 'folio->index + folio_nr_pages(folio)' by using
> the existing helper folio_next_index().
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
