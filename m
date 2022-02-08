Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC6C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Feb 2022 03:01:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nHGlP-0007ig-2h; Tue, 08 Feb 2022 03:01:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nHGlN-0007ia-Hw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Feb 2022 03:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VKOQk2qKWMw19lv2G35MPEh/AjK00aGqUA2xXV81Rt8=; b=Mp3666HLZ6zfQUVHFnzj/JdNuB
 vfHWxxQtYmALUUpnddXrDO2CzatZUgT/Yx5RjcGf+L59Ofoi6lZYACP87imggtnLLYH+9LTNP3ZBJ
 F17FPu0kuOjpt2IczM83yPAYsi79gT0BrljLa+ec+oknQmPMk4ubxMaqci4SMza6OqSk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VKOQk2qKWMw19lv2G35MPEh/AjK00aGqUA2xXV81Rt8=; b=CQnAwBk/EGKzXeJN+PpjCoX3PW
 O+1lW1H4EVdmtNpYbr21ZjQ9D1bLUfS9rxyStEXC2QYa7lfJTnKA3Jh+x0Qr6JFTJkiSdJ8LojvFJ
 6ZY4luIcXMQRIjbvaG2Jht7+5K0oOxJ654kYhhXc7o/6r2RNsgVB5FzSnV1VT7Owa1DY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nHGlK-0001xX-GW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Feb 2022 03:01:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 26CAA614E3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Feb 2022 03:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEE1C340F1;
 Tue,  8 Feb 2022 03:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644289304;
 bh=Ht6t76OsTRsMEhxprS6nwHplq7F1NvcCaazTw7NCFuo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=hT8+Ztz3uKXdhZGkA/jwU4LlGe9SrHVROfchSN1ln+GHcGB7rNvBY7LWFPQ+HIp8X
 Mtalo6L2OCkH7HJE9AYZj6o5yyeajjvk/rrUgWMPJ2Vj/7E4t2g3njNG7q02Gl73F3
 ClnDVA7hDwrYWOODGvSpYVNfWXhEeGQmF84GBc7AA6XWX9OV19kfRzNR37P0IZQdKp
 NrcWuSRDGNXLCSMFvbB1nYjzePgRoF6eVusKa9GalNF1vb98mfMEMyJHxBzyP1bL2J
 vts8VYIQdqgN5IPwXf3rehp5/cpwLXJqO4p+v97yAnIsUQCeEEwnDcsvFixm+Gv6He
 H1kMpVDCgOVtA==
Message-ID: <cb956fc1-e821-c795-bc18-07fa712faac6@kernel.org>
Date: Tue, 8 Feb 2022 11:01:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20220203174458.3598593-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220203174458.3598593-1-jaegeuk@kernel.org>
X-Headers-End: 1nHGlK-0001xX-GW
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: set project quota by default for
 -g android
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

On 2022/2/4 1:44, Jaegeuk Kim wrote:
> With this patch, "-g android" enables project quota only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
