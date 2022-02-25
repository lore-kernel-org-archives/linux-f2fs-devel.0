Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4559C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Feb 2022 03:08:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nNQxi-0006rV-Fh; Fri, 25 Feb 2022 03:08:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nNQxg-0006rP-SR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Feb 2022 03:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r/nZaq7qdcEJwjEoG+bCgVfu6XWqzyf1psbacFaPnBM=; b=TyZCeQZwkTQbatX4Mvz8z9tnvv
 gpFvHUGZeQCxS1HuHlG3b2Cn0p8GyVh0xQ3nnx1lmq1k565uFoAno9RhBmJXJcV0lA+HYrPXBkG2Z
 RrYON8RbWWgkXG9NoZGQ7/ThzR0OImXpn27vGIxZoTwUdxrfIrv8a+RBEYU3IdFEO1J0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r/nZaq7qdcEJwjEoG+bCgVfu6XWqzyf1psbacFaPnBM=; b=RToCr7Vn0nsL9gJ4ZbMRlkurFs
 xTHRGZkofio3RSg0xq3uD1Ur9nNiKp3tL39BBmOXjqFXyppa60r9stN55pZQzHbYD6Mh3jRVgPFFn
 jz1a2xTU0T6F8YaPEWf64e14DiCNGpzxKO2QXgh5v4ELgu7txm6bwunwQNAHsBjWRxps=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nNQxe-00EPmh-I6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Feb 2022 03:08:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 6C156CE2176
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Feb 2022 03:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156DBC340E9;
 Fri, 25 Feb 2022 03:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645758470;
 bh=BU9Hea8Fp60TY5OzrOeAri5+VBAOMYh/l6aBBbSri7o=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TinDmYzi1VW5lUeIom5wQgLkUgObNu9u7oARLNgDw4nnM/eSL1h0N8uSbB+u/TkFe
 Fhj8zvtNiMzGYOMcOtI7ULW3IFo6zBPIkQ4JR1DDDoNgMCq5NULkqPpoTe8M0Lm29q
 mhLBMhWGNPCg3By+BYe+zo7psdQfX8RVkJYS79QAEBNf9a9C0x6dhi4uwJTIF0c6vf
 eyHeJXS1Maz2CoJoB8v3ThI5d8oP9eU4kL/gsosSBEk2OsjrrIs4AAqq2R+w3IhXgH
 +36vZu5Od2i7vjF+6w7aAJIDBMUoLZPv8EnPGDp8oShNLmzYwD/K4aTCuaxBsmIOz/
 xDIn6DuANncPw==
Message-ID: <d8216020-b439-ca77-fbe2-b68dc44fba25@kernel.org>
Date: Fri, 25 Feb 2022 11:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20220203174458.3598593-1-jaegeuk@kernel.org>
 <YgL/HK2aGhFUQhtZ@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YgL/HK2aGhFUQhtZ@google.com>
X-Headers-End: 1nNQxe-00EPmh-I6
Subject: Re: [f2fs-dev] [PATCH v2] mkfs.f2fs: set project quota by default
 for -g android
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

On 2022/2/9 7:39, Jaegeuk Kim wrote:
> With this patch, "-g android" enables usr/grp/proj quota by default.
> 
> 1) -O quota : enables usr/grp
> 2) -O project_quota -O extra_attr : enabled prj
> 3) -O quota -O project_quota -O extra_attr : enables usr/grp/proj
> 4) -g android : enables usr/grp/proj
> 5) -g android -O project_quota -O extra_attr : enables usr/grp/proj
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
