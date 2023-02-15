Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C8BC64EC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Feb 2023 14:46:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pSJ2m-0001SJ-PO;
	Wed, 15 Feb 2023 14:45:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pSJ2l-0001S6-BH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Feb 2023 14:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tiwzMuGHItJAQKSjrVQzL5t5IG9/7v0BvQMavAqXzqE=; b=Hh6pZtWVg85OnQcUpjXCLAnxiN
 Z1vF2VjVzOFauzTYnX10dG7e7J3Itl11yjjjpsU3rSr1nak5Bc4W9KOBkfD8m0z10fS0/twkZ2bRy
 2QpEG3WkSCB9IrJova3oYRjkoE2N7joI5gonJLowhfaJ6pGEmCXoFQVXcNh9nQWhs6wI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tiwzMuGHItJAQKSjrVQzL5t5IG9/7v0BvQMavAqXzqE=; b=cJYBXsmQ3gT4V3xXXULytIiVq0
 A4vdMxNDi9s5BkqKiA+N3wfPUY+v42vhHNaraqg5+7ny6SXLjAfZ5WQi29WXKcW4588E+ooRzYAUY
 sJPXeF5BGnYPtLECgFw7rIhFeFB8sx77/RZXUle4ckzMPAhA4e5kddN1iTEshOnVpWzM=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pSJ2j-0006l4-1Z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Feb 2023 14:45:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 865AAB82041
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Feb 2023 14:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1839DC433EF;
 Wed, 15 Feb 2023 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676472350;
 bh=i7XJdYYy5Ec8OzUEFnRgUnGX3zdu+ChHpKa9KrxeWT8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bKr6YjHORC8EsH9VafAjrlUiaCMJvXEsZ7Zl0Iz0hCCUyCqcC0BSR4LuXEOywhBls
 lUMSTDN3h8okUruhrmpzamMTKPjfG8SkNB0Zm7yqZRXE9JDnALbMfreC38+hNlgh41
 5LS03rOr52DNRqUBeclMssI/Iqc9XKpFP9qJQAvCGNNIJu9Yt9uqDEqvnJz1Lhnr56
 9wyCUomS4yeu07y+dQEzBvz5fh2x1Ep8TFkUoz6f+P9ErUsiH6Sm6gNwR/1xroXpvt
 AQEXQAyqA5AprLWMX2Jn5EDYSPkinz0k4hVBAll1fjauDrddiK/faakSpyFSj7j5dm
 JDwmGhLfPGZzQ==
Message-ID: <4eb60628-1546-1bcb-b71a-92368d7116eb@kernel.org>
Date: Wed, 15 Feb 2023 22:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230214235719.799831-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230214235719.799831-1-jaegeuk@kernel.org>
X-Headers-End: 1pSJ2j-0006l4-1Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: Revert "f2fs: truncate blocks in batch
 in __complete_revoke_list()"
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
Cc: stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/2/15 7:57, Jaegeuk Kim wrote:
> We should not truncate replaced blocks, and were supposed to truncate the first
> part as well.
> 
> This reverts commit 78a99fe6254cad4be310cd84af39f6c46b668c72.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Oh, my bad, thanks for fixing this.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
