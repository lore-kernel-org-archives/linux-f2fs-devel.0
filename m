Return-Path: <SRS0=o+w2=I4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490A3C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Mar 2021 01:53:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D664E61935
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Mar 2021 01:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D664E61935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lR3ZN-0004Bk-C6; Tue, 30 Mar 2021 01:53:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lR3ZL-0004Bd-IS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Mar 2021 01:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cnV4MA9fSlWOWchBi3PlxejUfVnjtyXIie2Y1EvBfA0=; b=AWUfmZmZ634PW69EzkDqqtX2fo
 86e5Onm5DoMOZjq0FZEKIjpA4tISKsrJ0yQuSN0gBZFgSTNqbSL2A1K9WzlDlS7IYy8Dn5/cUD6yl
 I8hvbOrHbEnUr2Il5F+JEBPY14qw4E7pmCrsCdZMq5A42v3cvSS/EcqI4R9u0TZwxyss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cnV4MA9fSlWOWchBi3PlxejUfVnjtyXIie2Y1EvBfA0=; b=XX/XALUjtnJ7a/6EDPX3OQG0ik
 dCt1lLk3Oz2MsbgKvmuycC+m3EHTYlXnC2rVXSBeRFUgdVWRuttuhW/Gyqf02dQOsxVBAevf8VsW8
 mU2iKGzj2880zolTs19pK2otiApBAY2pMDUYy46CJJ8BAfIx98jqI7soa9iLIEedIFcg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lR3ZK-00At2I-1E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Mar 2021 01:53:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E37260C41;
 Tue, 30 Mar 2021 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617069196;
 bh=GevyNR3XBe9JE7jNR+C8DY51gkGc4pzFml1BcSA406Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q5qJ0nFahBP6GKD/dJ8ZoylIMmracSMkrLJT/lMIaVQsirQQDmobUKooTFBmZAnPu
 aUwiEKocTK2IblXOwGicPfx1kesw3uK2nQsdYUsHfnxUiMUPKbo3T/H8G9t/0CdZIt
 hFZkDNzfyTkzmR4LWgY49O/sziwlogOrSFqsLze3HfXi4hNB0yzSGYSQ2jsYTxs7hp
 /B0Vpj7pfQxQT5cB07v69yDt1Ui/WQ+RkhTrCJoCMpyICo6Kz6yPnS1tqWwvU1mWqT
 bl7OzwZIWaIDZ8IkHPfltNPTxBNaXYgCfcTI8WxfMjcLG/G51Nr4zM9r0Z7oGC7+Aq
 gKk3hrBJYGQCg==
Date: Mon, 29 Mar 2021 18:53:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <YGKEitULkZmMwk3f@gmail.com>
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
 <20210329204240.359184-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210329204240.359184-3-shreeya.patel@collabora.com>
X-Headers-End: 1lR3ZK-00At2I-1E
Subject: Re: [f2fs-dev] [PATCH v5 2/4] fs: unicode: Rename function names
 from utf8 to unicode
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
Cc: tytso@mit.edu, drosen@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 andre.almeida@collabora.com, linux-ext4@vger.kernel.org, krisman@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 30, 2021 at 02:12:38AM +0530, Shreeya Patel wrote:
> utf8data.h_shipped has a large database table which is an auto-generated
> decodification trie for the unicode normalization functions and it is not
> necessary to carry this large table in the kernel.
> Goal is to make UTF-8 encoding loadable by converting it into a module
> and adding a unicode subsystem layer between the filesystems and the
> utf8 module.
> This layer will load the module whenever any filesystem that
> needs unicode is mounted.
> utf8-core will be converted into this layer file in the future patches,
> hence rename the function names from utf8 to unicode which will denote the
> functions as the unicode subsystem layer functions and this will also be
> the first step towards the transformation of utf8-core file into the
> unicode subsystem layer file.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v5
>   - Improve the commit message.

This didn't really answer my questions about the reason for this renaming.
Aren't the functions like unicode_casefold() still tied to UTF-8 (as opposed to
e.g. supporting both UTF-8 and UTF-16)?  Is that something you're trying to
change?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
