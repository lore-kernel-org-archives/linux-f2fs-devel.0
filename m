Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A53C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 18:50:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrOkH-0004Z2-Gi; Wed, 18 May 2022 18:50:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrOkH-0004Yv-2w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 18:50:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZNmX6nNHzUV65tOQmC0MnBGl2bsZ85bjRjMmjVXuCic=; b=Y2LWLJNgz0jPCMP1rRo44uuX2J
 ZulKrLqGUYPgAw6TyJkOt7LfuVzFyplAILAZdvWL8gWv34bKiSN8wA145Td8UlztnNNcoprxB8xbp
 QNBBJX9LiX6VrEpUzzYFZ7hYOIXU2RYq7XS6P0f0hf2rfrq3Y1Id/nc3xrvrS9JFsiIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZNmX6nNHzUV65tOQmC0MnBGl2bsZ85bjRjMmjVXuCic=; b=JP3Ic1z66lZJuWwJs7NB5zLxQ/
 DpoTpasyBgPJv/U3f6wn1yHEfuR8AirroDqZ9TXfopzbAvikk3Czku9HFV4z8qOKlm4WTSaROx8sL
 9vAxaBoOVNvX5o2CEhMQNoB1svaY79bNN5+aZjYbZfMlDI9EM3d4ZArEmb/TzDe70DSw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrOkC-007Idf-1I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 18:50:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A74C9618B9;
 Wed, 18 May 2022 18:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6754C385A5;
 Wed, 18 May 2022 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652899794;
 bh=+Apu+Nel2cEDwc+hc9Dn71n7RNyqrWqJjXXdOwbxaDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H6ExxwSk+WU0hzWKNiP6k4MURxiYIRBOwkNNWsvVn/XELTkLBZBQTY0L6ojiC8538
 Nu68TmKdYlI6sW8Cbqa1wTsBu26wHnUIDiHEmpoOI/mwQkyPIG4rmBP+MCZ5BT38oG
 6SO+z/6VCtLV+pY+POMWSN/wYgDN4HTNwKu0bpYYGgE6iOBPPjNurfGEvTyhossmTW
 cE/ISHD6/1+JC+Izp+9PNhS6yRZ+YqCVn3oXvp+bUqHrBx5a+h7TZWDMPdool26Vq7
 b90/I5bpponsYE8ALi52lgsoArwQgaiW+pbekAqb07EGocvR/tE0RIdMvnGIs8mIU+
 gVXK26GpYsCDA==
Date: Wed, 18 May 2022 11:49:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YoU/0I1CzfDqY/yU@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-2-krisman@collabora.com>
X-Headers-End: 1nrOkC-007Idf-1I
Subject: Re: [f2fs-dev] [PATCH v5 1/8] ext4: Simplify the handling of cached
 insensitive names
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

On Wed, May 18, 2022 at 01:23:13PM -0400, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in ext4_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> --
> Changes since v1:
>   - Simplify hunk (eric)
> ---

The changelog needs to be deleted (or moved below the scissors line).

Otherwise this patch looks good:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
