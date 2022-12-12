Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE50CC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Dec 2022 13:50:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4jCP-0000Ku-VT;
	Mon, 12 Dec 2022 13:50:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p4jCH-0000Jf-CC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 13:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/eFGbuQFH0Xin09+n+kezpiOwBkjQxXvNcJgBGb/II=; b=k1e1M2/vs8jbP+lu9QlGLLCyL9
 nTmdiRY/69xkTguXHZB0dT5+5vXciRqk1qZLqjLL+WiwhAxf3qgd4ifJL5dUfULqSRwgGMoLx571x
 E7JB3Ofz55j+iSXmDnmH9BUcH4W5L5BSUiar/hwWdHa6qabk+2SkLlnsK9EQA76IsXDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H/eFGbuQFH0Xin09+n+kezpiOwBkjQxXvNcJgBGb/II=; b=A+9SqahPZ/2jUNTFd65RzQxBwS
 WsQnzAWJg8q3XZ+/bSDjH4oh55bhzN4BbGdOlCaQ7/muYvRt2NFjhDwy4Vs0lt7jXNO3MAHKDVPY5
 k40ALblNh7sXopmoxQ9eVjrUUFUWfpu2p99ySOaEKiUJfJL0tyCMfQ+gk/0MsfYyN9Fk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4jCF-00En8z-HQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 13:50:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 06F72CE0F42;
 Mon, 12 Dec 2022 13:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52742C433D2;
 Mon, 12 Dec 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670853011;
 bh=aCRBoLb0YwdtiYohSjElCBoIIed7LaVrdwrE9FuvRCY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HisaF9J54DDZsmM4cYHCx2OsCOKayYe/1tDBrdjjhtAqEV7qUhsIiO5ZZAqzbnjg1
 8ldiR+SfNHvADy/XHvUlAdZWkmj8kBlDOlLUIwTZbMyc7uCibbOaQuVyOI4qMujOT0
 xLLUOWWaOIe/46TV51ZHdyPVP2cGtliWSCt9z+92Cv+r89lE0ybcZtkHHTTInS3c4p
 waAw+v52B67ltwKdPsl3y536VwTpn8bkFlgKCXwUMuooQzqr2tvmxX7pHDf9wKTuoE
 k6/3NmL53Xqgq8//X5mY87idXJ5hv0446ZrhflcEwT0XKP3v3SbcGyhvL+nIeKiF+B
 PM2fZ4thAg+iw==
Message-ID: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
Date: Mon, 12 Dec 2022 21:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <3f2c81f8-7946-d2e0-8768-6f0b03282944@kernel.org>
 <20221212130554.79049-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221212130554.79049-1-frank.li@vivo.com>
X-Headers-End: 1p4jCF-00En8z-HQ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't call
 f2fs_issue_discard_timeout() when discard_cmd_cnt is 0 in f2fs_put_super()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/12/12 21:05, Yangtao Li wrote:
> Hi,
> 
>> static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi) {
>> 	return (test_opt(sbi, DISCARD) && f2fs_hw_support_discard(sbi)) ||
>> 					f2fs_hw_should_discard(sbi);
>> }
> 
>> It looks the logic is changed?
> 
> For a storage device that does not support discard, and we have not actually
> issued any discard command. I don't think it is necessary and f2fs should not
> be equipped with trim markers.

The difference here is, if we use f2fs_realtime_discard_enable() in
f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
when discard option is enable and device supports discard.

But actually, if discard option is disabled, we still needs to give
put_super() a chance to write checkpoint w/ CP_TRIMMED flag.

Thanks,

> 
> Thx,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
