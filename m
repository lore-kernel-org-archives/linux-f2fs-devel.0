Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A275C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Sep 2026 04:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DIKCcyj5MbRiKQvjiubVGKKjrVYMnOzm+/jl//aIVIo=; b=TWdOvS4pxW2bKHlhoa4AKV9yf/
	IaYoNgvikIwa+MuN9RL7cQIN69Po4Ng5/oiP4ShncXwwDVBX32/kfAh2rbwJ51XF1HdwJ6cqoSbiy
	ODRYrbsSIe+DoYi58mH2dLezE2+gPpbjdURKljGR4C8HOhOGF5Bc7q2pEz+q3e3czvjE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2i7A-0005UL-DY;
	Sat, 05 Sep 2026 04:34:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x2i78-0005UE-3S
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 04:34:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/rJHoUSAd3aRw+KHlZHT1r48o0hG7/WcffBup2E6EjE=; b=HE43NMutSQYtDWqPRbzHGahex+
 h35i4JcEFtBuXxVe/M8ZezhY1HAObsn2svVx7sXLgnoaIFc14H/VemiZxHy58UgQaqiBix4AKJRCh
 I9SLSydNHuAytNe9ZKq8UO0A1aiQOoatcoeq9TwKuVUYqjcdKo0NLUcTawwJ91/Lfgy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/rJHoUSAd3aRw+KHlZHT1r48o0hG7/WcffBup2E6EjE=; b=U+2EdZFRD51q13nAX/tpZhKN6x
 8odSou17X6PcWOsd81SgJZ1nhAo1YzvqjVBFCzwdR1WtL8sdpP7kJl4Zi6Io1RQjCrkd/16//osTY
 Z2VGMhvebQ6IlmjOTTlpkMML/WqSaPF+85dP0O0RnFVizrSZSXIkNRhUVzNt2FxogzrM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2i78-00031i-Bi for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 04:34:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0B7F41774
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  5 Sep 2026 04:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C488E1F00A3D;
 Sat,  5 Sep 2026 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788582884;
 bh=/rJHoUSAd3aRw+KHlZHT1r48o0hG7/WcffBup2E6EjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EKbPODKlr4o4K54yQQ3ymStV6g6PtLiZs5DYITy2VfIPfxUZhwecp0fLnsg6CLVVZ
 adTwLJnuscMKpopheQA2HOjZVj2OHkaEX7hO+TwkDZwII+odcAxNVswPSH8HEgxj/A
 4v+7qdq2xMJK3BUv9ODF4/vpMfUUmW6PU56q+64ct37no9Dd1pf70aJIj3uz+chk1i
 zz6JAL3WlEoeQMB94BumPsMh8DiNxBj0I2QV6aqxEHeIQyqhgxZzew2kVInATs4WDu
 LzsbEjx1992M+BER5WdvZ9/0X2F9GpuR8TZ3HLYp+USNeiGskgiuCqq583e9dK1z3B
 CUECbsDMuz6fg==
Date: Sat, 5 Sep 2026 12:34:39 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <apubxk9g6mWXvX5c@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20260817091137.1503208-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260817091137.1503208-1-chao@kernel.org>
X-Headers-End: 1x2i78-00031i-Bi
Subject: Re: [f2fs-dev] [PATCH] f2fs/009: fix race condition in orphan inode
 test
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: jaegeuk@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 17, 2026 at 09:11:37AM +0000, Chao Yu wrote:
> f2fs/009     81s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//f2fs/009.out.bad)
>     --- tests/f2fs/009.out      2026-06-12 08:46:32.819432390 +0800
>     +++ /share/git/fstests/results//f2fs/009.out.bad    2026-08-17 13:09:35.000000000 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 009
>     -Silence is golden
>     +can't find corruption
>     +(see /share/git/fstests/results//f2fs/009.full for details)
>     ...
>     (Run 'diff -u /share/git/fstests/tests/f2fs/009.out /share/git/fstests/results//f2fs/009.out.bad'  to see the entire diff)
> 
> HINT: You _MAY_ be missing f2fs-tools fix:
>       958cd6e fsck.f2fs: support to repair corrupted i_links
> 
> f2fs_io write ... atomic_commit ... 5000 runs in the background and has
> an initial delay before invoking F2FS_IOC_START_ATOMIC_WRITE. Without a
> sleep in the test script, rm and _scratch_shutdown -f run immediately
> before f2fs_io enters atomic mode, causing f2fs_io to fail and
> preventing the orphan inode from being committed to the on-disk
> checkpoint.
> 
> Add a 2-second sleep to let f2fs_io enter atomic mode, record its PID,
> then shutdown -f to ensure the orphan inode is written to the checkpoint,
> and clean up the background process properly.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/f2fs/009 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index afb3bc98f..df8bef96c 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -106,10 +106,14 @@ check_links 0 0
>  touch $filename
>  ino=`stat -c '%i' $filename`
>  $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
> +pid=$!
> +sleep 2
>  stat $filename >> $seqres.full
>  rm $filename
>  _scratch_shutdown -f
> -sleep 6
> +sleep 4
> +kill $pid &> /dev/null
> +wait $pid &> /dev/null
>  check_links 1 0 $ino
>  
>  # hardlink
> -- 
> 2.49.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
