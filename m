Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF893C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 03:44:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrX5v-0006Io-5P; Thu, 19 May 2022 03:44:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrX5h-0006Gy-VO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 03:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zak7cY1ghVtrR7oE5ZqXCiI65Xxns290U25MrzAFK5w=; b=lkEoeVdfsJorYzB4nsNPA5aGkV
 YvWS+gB6OPMzJVh+LlVvgDBLRrPb61b0lBqubUCqh6eYANVq2UvQ9cZPJn9jfRIOUKK6yBIBDXocs
 bVzeXNQFjE+el2lQaiDqgbMJ7mm99zaofB2/MHgNM4B7tQ6GEH5woqg+uTnOOIp+HfkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zak7cY1ghVtrR7oE5ZqXCiI65Xxns290U25MrzAFK5w=; b=l4JoT9RieKEwPPBg9pKSrzET99
 Rzbk5FEIVrrTu4PDpMlGMRVPLElFf7ViBgqCV2Vn6VQz9DlafcPDOl8GAnLbEVMhdqiBJM4ddtuIt
 4ywjr2IUPWKWIOyIQ7tWgV+mtuph9ikkoDkS/z8rYr4+ZlKcLSDrDXqFZcIZxwHW6m4I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrX5g-008AGd-Dm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 03:44:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 079AC61827;
 Thu, 19 May 2022 03:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA65C385B8;
 Thu, 19 May 2022 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652931878;
 bh=ekh/FhP84EQQVSkLScUnt4yyZGY4hkjplyJ/xocL9Jo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RXm2YlpG7htAqF1Rk3DrkQ3sJ+UeugX93urKrVYxjBOc70gNVgh15hdDq+5V6i0of
 X7vWv7wSB9llWvwr+1C3HRBobnAWUowMjIN457pcHV28CMpOsljpEjTx4g3jxg/4hn
 Rituwib+6Tbdl15AWSG3E6MdB4M+D0uifztwKybUzZQfVhaa7vmD6JFWT8kgTNHuhY
 BIa8mUprBeF+cdQIiUxGOoGBy0vLuArKskMFSvgKEcwQfS7zoo/Z54pgwC0aorG/Gi
 8W4eZWvPNlpPfdSUEpjrzwjMhmxdu9cjYX+PL6sRO9Zdgv1odkClvot+0+uN5h0b3j
 CjZr6ZdHb+NDw==
Date: Wed, 18 May 2022 20:44:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YoW9JEvePQFMQXeR@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519014044.508099-8-krisman@collabora.com>
X-Headers-End: 1nrX5g-008AGd-Dm
Subject: Re: [f2fs-dev] [PATCH v6 7/8] ext4: Move CONFIG_UNICODE defguards
 into the code flow
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
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 jaegeuk@kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 18, 2022 at 09:40:43PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v5:
>   - Drop err variable (eric)
> Changes since v4:
>   - Create stub for !CONFIG_UNICODE case (eric)
> ---
>  fs/ext4/ext4.h  | 47 +++++++++++++++++++++++------------------------
>  fs/ext4/namei.c | 15 ++++++---------
>  fs/ext4/super.c |  4 +---
>  3 files changed, 30 insertions(+), 36 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
