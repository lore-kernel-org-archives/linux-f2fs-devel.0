Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A88C636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Feb 2023 09:43:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pRVN6-0006wD-O5;
	Mon, 13 Feb 2023 09:43:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pRVN5-0006w7-SA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Feb 2023 09:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YotNv4bwu4ESViMER/ECrCIWJqxoDn9YMSlVkLHWNwk=; b=RxtdYnkSoVh5/UafOLqnxKa4Mn
 7WpQfkJlKPmf431usbxtOrBYHa2hTYDMtF2GLHHMQ2J4I0oN+FXDd112CQpKbAJWDWZq6vtIfleBP
 Li+POC4DkcZjxrBgjTkYoTHa/080IS3m/tyEHlNI7KJiDJSP7wWpQd6vkqzrQqyffjcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YotNv4bwu4ESViMER/ECrCIWJqxoDn9YMSlVkLHWNwk=; b=hgtPmFSwfTX4/BQZT3HeIZTHN6
 aSb3WtQ2nbCfOeerTntd3WOgNjGZ18JbzxH/nEdw3XGy4F9+OasX4kXzLxv/DFfcn5loikIteeIvi
 dnar860WzBcltpA+X+avT67RHL68ff+dzHbsmoaBvBGUc+hcgbV5dI8kC/J7Fec7cw2c=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pRVN4-002deh-JF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Feb 2023 09:43:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 50D06B80EF5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Feb 2023 09:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766F2C433D2;
 Mon, 13 Feb 2023 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676281411;
 bh=rxBhvpH1nzpKUMUDEoNBxiK/UF1op7tnyumEEvgOoPk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=a2Os73YITRkTVN/cM1BXuJtZQ8fc+vL2GPmYYehd2AtM+OGBhHzFLc3hZmweWYm6o
 DbGXtL/kDS+h9gaQ5zKN+Xy0sCycs4gng3/WyKJivQ2dyoy+FlXpAI92Lne97p2dCf
 fbhylKcXAAW9yYhB+C6VDGf8nHliBMUT0a0i/q3HN0isQuOguOd2CDBdRwEdRJv7zn
 5fpCBEEv2HmaQxJvKfeCWJjEuWAT9dyAG+mX1MNj3oHLXRMhFY7O83a1rnQi68q4L8
 9p8ck4XwchyyXZBWATYlL+15g/cpHV8UamKZ9kNrstcR+4d/o1OErMSy04aofScGCZ
 05N2zvQRpyfDw==
Message-ID: <0eea596c-9071-8c27-db98-eebac4634058@kernel.org>
Date: Mon, 13 Feb 2023 17:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20230210213413.3472621-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230210213413.3472621-1-jaegeuk@kernel.org>
X-Headers-End: 1pRVN4-002deh-JF
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix # of total segments
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/11 5:34, Jaegeuk Kim wrote:
> TOTAL_SEGS should include metadata segments and main segments.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
