Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37686C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 May 2022 10:06:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nsiU8-0004Mn-0S; Sun, 22 May 2022 10:06:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nsiU6-0004Lv-VI
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 May 2022 10:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lhOmi+ZsQ3Fua+U0Rc/fbOHHlxkp7bdukX0B2+0GF8w=; b=bhhanaYZpD9Fwx4aeyt/lR4LAF
 aL5gOGQ+9YlrLqlZ4A0nzE4+QT2o2GIn8VqVgXoQoL7FRy9RDr4uoVAQ0GQvCeZlcc5Ydz/mK82x1
 9M1LSoMYyyuTvwIKEvrO2zuzYc0m0tCEdaroZdcI6AveU3IbTkvw9VPoNWH1E/DUjuBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lhOmi+ZsQ3Fua+U0Rc/fbOHHlxkp7bdukX0B2+0GF8w=; b=MmIF3uSlZbv4g/9xqPzyyRBkdQ
 N9d/XhAJESG72byml5elgiorROfK7aFG5AMVH/DD+zaldOMPGVCj1y4npbOd9RxJZ5Layi7K9DhEu
 vCQrsvyPo+dz8Ph1YTDXExz8E+qAttxCOuv9X+4dFDzGKQpOEZ5Q7QAUbn5TUy9aO2rg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nsiTt-0001AX-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 May 2022 10:06:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3BFB560ED5;
 Sun, 22 May 2022 10:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62A4C385AA;
 Sun, 22 May 2022 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653213988;
 bh=UPbiNgGAwL5aqC80FZUlkF31vbhQbeH7p2NfiK7RD2M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eA61M92tHgqSHqaH2+zWhVTbhBium3ZcdMEvpGQ2mcCdkiV08IntwH/YZspjp9Y6p
 l77Ybc5invmaeox5YhBnkU/2tDJHj2cncl+YbuxTshEaZ+N6GINcx49jQsdTWe1NR4
 XYDq3wSJH2EqNJd1zRAWsoDSsAlSFCkpqeZMqOI+9qSkU7NtluM+Iee7bibENAYuaC
 pI4xjE4EWVvCDlPBGKaXFkskkpsoFyzNg7MsN7KowN/tFErtrwCzsGimQT77RUGAPI
 0pmfvuiGnjRRsCUGDwf0uPhz8j3sxgS35sQSbBDFmrqEs7wKFhm55JSHTrFxYEle8w
 Kb5FTKuQm3M4Q==
Message-ID: <30ab0c63-4576-a9a1-8dd2-aa0e79ddd59f@kernel.org>
Date: Sun, 22 May 2022 18:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Julia Lawall <Julia.Lawall@inria.fr>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220521111145.81697-93-Julia.Lawall@inria.fr>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220521111145.81697-93-Julia.Lawall@inria.fr>
X-Headers-End: 1nsiTt-0001AX-LQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typo in comment
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/21 19:11, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
