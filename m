Return-Path: <SRS0=9Epz=MY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05433C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  1 Aug 2021 07:04:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54D1601FC;
	Sun,  1 Aug 2021 07:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A54D1601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mA5WD-0007g9-LX; Sun, 01 Aug 2021 07:04:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mA5WC-0007g0-3z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 Aug 2021 07:04:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GC5kyfNHf0uebyQTOXFEbg26ZhVQQXtbrK2nbuuOZyc=; b=EHQuNi2FgxgSs9bTvZefALtFJ1
 U2VxNw88ktbpQc7JtM9Rpyy7v5RmlvlcUmwF4TqTSqM766fBizOZUkBWUgxnYxirvpw+QNBGEirxx
 e2/TCoVfTb4LjNGTlqfb4YlxUwFC7zuukoLPMNsJ7ylSvunQhm5H7Dosl5pt91juQyYA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GC5kyfNHf0uebyQTOXFEbg26ZhVQQXtbrK2nbuuOZyc=; b=XblEK4D00Rf1o/A2UEJNjzjKQN
 Qg5yfXc+FoRJGDvV7arHhmJL9Heui1m6pXyFVvI2Taza/qcIBHCdjA3PiE97oC5pWd1nA3TafctwX
 0U2vlk2vZ8vRln9IOxyFt9BgE+vt+sn+X+OGsd4rFnPeMWE/sdZmjsdbjJ+K12D5x9Bc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mA5W2-0007IX-WB
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 01 Aug 2021 07:04:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 248A1601FC;
 Sun,  1 Aug 2021 07:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627801439;
 bh=GC5kyfNHf0uebyQTOXFEbg26ZhVQQXtbrK2nbuuOZyc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lXWT+EDRqJ17uyfPuxC4HACMEsAKTP+Vce6lFEWAnpOJ3n8oba0vKI65E2hW+f6yU
 SdhhN5aisKocX+zvBBQF3gXes4KLsyeaB78z5sY2jQMujl8+WHTq3kuA4LZ+62Lbq3
 OG37nJmtfh2ieYuhRnEfzAfM0doOQEaaG1eP5VTzAJ5WVdZg5sSBXWH38nPJviBgGQ
 xfa0W3huyceFHPNiQem5jLLYt8NFb4DBZfTI4ODyEB3rFU2NMtpiZntLYQTZlsI+Aw
 UPUeDIROqFdbVJIJEE4kYuhe9LELGwtxeBBIfR8ZHj/nnVR/tHlIdDKykFMANbF86S
 Wrbn1os3+0AkQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
Date: Sun, 1 Aug 2021 15:03:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQRQ4kHvdRTBnb10@google.com>
Content-Language: en-US
X-Headers-End: 1mA5W2-0007IX-WB
Subject: Re: [f2fs-dev] [RFC NO MERGE] f2fs: extent cache: support unaligned
 extent
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/31 3:20, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> Currently, it only works in readonly format f2fs image.

There wouldn't be any race condition because unaligned extent only works
for ro feature now?

> Is there any race condition between the address in extent_cache and the one in
> dnode? I feel that we could synchronize it by locking its dnode block.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
