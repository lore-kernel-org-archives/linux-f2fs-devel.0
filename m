Return-Path: <SRS0=Uz9g=FE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6647C64E7B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Nov 2020 15:05:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205CF20725;
	Mon, 30 Nov 2020 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kS2ci4pw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PXfZgsL3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoL9rPlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205CF20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kjkk4-00057B-SR; Mon, 30 Nov 2020 15:05:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kjkk2-000573-Fv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Nov 2020 15:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TyMKXmvfj9bZfo+zkC6BmBpXsuQNkgv9LjUTgbypbfU=; b=kS2ci4pwMyiH386UfNwTTumhPX
 /zAzrLHZ2R1V1xocu+I2hm/rXokG+efkxzV6Xl9/pdf8ahrMOoEPtkZ4pYZohTxXuYoW0N+0mpsrQ
 NxsHdorQXIdzBGAxAuBUEaa6Q9t+mevG0/NHLUKKWpOrPJJ+KDWAVa2qFOUHLtugcTmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TyMKXmvfj9bZfo+zkC6BmBpXsuQNkgv9LjUTgbypbfU=; b=PXfZgsL3lp/XX8A+wKmK+XmeTW
 3KrPldspz5WE09abN759McZag0nJTJjjz+jwlZGKzZK+lM/lhVlB4uBbWoD9LNW2e73Jk/oqlbnPT
 bM6ksTu/T/birCwjyVO+PDbZA+XSDIuccfVdXQG9NTjx2nedsHEewH8TFnecK0vNFCzM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kjkjt-00Bz7V-F4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Nov 2020 15:05:26 +0000
Received: from [192.168.0.113] (unknown [49.77.180.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A220206D8;
 Mon, 30 Nov 2020 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606748707;
 bh=19bKj2nvufajNmxbblRlprgH0MBleMF9z+mA43UKseQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=CoL9rPluXLoBbupX/R8wqXk1xMQI1/I7XaOZVGmTyVOx8eG7dJ+hd8BtJOsgfUsMQ
 PoNhITbPxTL7DvnczWqXQYuPkkW5CqRmWXZQDokANHbqu0ogELC4LVzXUy7IsPBT1U
 QjHamTejM2FxlcLElSmg04jF35ccP1/qvs0hHPNM=
To: Ju Hyung Park <qkrwngud825@gmail.com>, Chao Yu <yuchao0@huawei.com>
References: <20201130112648.95504-1-yuchao0@huawei.com>
 <CAD14+f0b5ZqK8EPP+rgMf-NmJXCcOYnqX71QMjViOkF0Q2xsaQ@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2b9f01e0-577b-b462-d6e8-777380588542@kernel.org>
Date: Mon, 30 Nov 2020 23:04:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAD14+f0b5ZqK8EPP+rgMf-NmJXCcOYnqX71QMjViOkF0Q2xsaQ@mail.gmail.com>
Content-Language: en-US
X-Headers-End: 1kjkjt-00Bz7V-F4
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: support lz4hc compression
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ju Hyung,

On 2020/11/30 19:35, Ju Hyung Park wrote:
> Hi Chao.
> 
> On Mon, Nov 30, 2020 at 8:28 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> Add a new mount option "compress_lz4hc_clevel=%u" to enable lz4hc compress
>> algorithm and specify the compress level of lz4hc.
> 
> Wouldn't it be better to introduce a generic mount option like
> "compress_level=%u" to allow other algorithms to use it as well?
> 
> Or retire compress_algorithm altogether and follow btrfs format, which
> I quite like:
> compress=lzo:1, compress=zstd:4, etc.

Agreed, the implementation looks better, let me try to implement latter one.

Thanks,

> 
> Just my two cents.
> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   Documentation/filesystems/f2fs.rst |  2 ++
>>   fs/f2fs/compress.c                 | 22 +++++++++++++++++-----
>>   fs/f2fs/f2fs.h                     |  8 ++++++++
>>   fs/f2fs/inode.c                    |  4 ++++
>>   fs/f2fs/super.c                    | 15 +++++++++++++++
>>   5 files changed, 46 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index 8830a11a11be..cda30ea124ee 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -264,6 +264,8 @@ compress_chksum              Support verifying chksum of raw data in compressed cluster.
>>   compress_cache          Support to use address space of inner inode to cache
>>                           compressed block, in order to improve cache hit ratio of
>>                           random read.
>> +compress_lz4hc_clevel   Support to enable LZ4 high compression algorithm, compress
>> +                        level range is [3, 16].
>>   inlinecrypt             When possible, encrypt/decrypt the contents of encrypted
>>                           files using the blk-crypto framework rather than
>>                           filesystem-layer encryption. This allows the use of
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 2ec34168adbb..233be7f71e48 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -253,17 +253,24 @@ static const struct f2fs_compress_ops f2fs_lzo_ops = {
>>   #ifdef CONFIG_F2FS_FS_LZ4
>>   static int lz4_init_compress_ctx(struct compress_ctx *cc)
>>   {
>> -       cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode),
>> -                               LZ4_MEM_COMPRESS, GFP_NOFS);
>> +       unsigned int size;
>> +
>> +       size = F2FS_I(cc->inode)->i_lz4hc_clevel ?
>> +                       LZ4HC_MEM_COMPRESS : LZ4_MEM_COMPRESS;
>> +
>> +       cc->private = f2fs_kvmalloc(F2FS_I_SB(cc->inode), size, GFP_NOFS);
>>          if (!cc->private)
>>                  return -ENOMEM;
>>
>>          /*
>>           * we do not change cc->clen to LZ4_compressBound(inputsize) to
>>           * adapt worst compress case, because lz4 compressor can handle
>> -        * output budget properly.
>> +        * output budget properly; for lz4hc case, keep it as it is.
>>           */
>> -       cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>> +       if (F2FS_I(cc->inode)->i_lz4hc_clevel)
>> +               cc->clen = LZ4_compressBound(cc->rlen);
>> +       else
>> +               cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
>>          return 0;
>>   }
>>
>> @@ -275,9 +282,14 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
>>
>>   static int lz4_compress_pages(struct compress_ctx *cc)
>>   {
>> +       unsigned char clevel = F2FS_I(cc->inode)->i_lz4hc_clevel;
>>          int len;
>>
>> -       len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>> +       if (clevel)
>> +               len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>> +                                               cc->clen, clevel, cc->private);
>> +       else
>> +               len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>>                                                  cc->clen, cc->private);
>>          if (!len)
>>                  return -EAGAIN;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index d32065417616..d3d5583ea9e5 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -149,6 +149,7 @@ struct f2fs_mount_info {
>>          /* For compression */
>>          unsigned char compress_algorithm;       /* algorithm type */
>>          unsigned char compress_log_size;        /* cluster log size */
>> +       unsigned char lz4hc_clevel;             /* lz4hc compress level */
>>          bool compress_chksum;                   /* compressed data chksum */
>>          unsigned char compress_ext_cnt;         /* extension count */
>>          unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
>> @@ -736,6 +737,10 @@ struct f2fs_inode_info {
>>          unsigned char i_log_cluster_size;       /* log of cluster size */
>>          unsigned short i_compress_flag;         /* compress flag */
>>          unsigned int i_cluster_size;            /* cluster size */
>> +       unsigned char i_lz4hc_clevel;           /*
>> +                                                * lz4hc compress level,
>> +                                                * range: 3-16, disable: 0
>> +                                                */
>>   };
>>
>>   static inline void get_extent_info(struct extent_info *ext,
>> @@ -3932,6 +3937,9 @@ static inline void set_compress_context(struct inode *inode)
>>                                  1 << COMPRESS_CHKSUM : 0;
>>          F2FS_I(inode)->i_cluster_size =
>>                          1 << F2FS_I(inode)->i_log_cluster_size;
>> +       if (F2FS_I(inode)->i_compress_algorithm == COMPRESS_LZ4 &&
>> +                       F2FS_OPTION(sbi).lz4hc_clevel)
>> +               F2FS_I(inode)->i_lz4hc_clevel = F2FS_OPTION(sbi).lz4hc_clevel;
>>          F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
>>          set_inode_flag(inode, FI_COMPRESSED_FILE);
>>          stat_inc_compr_inode(inode);
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 39fad324ca52..98be4d87e067 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -461,6 +461,10 @@ static int do_read_inode(struct inode *inode)
>>                          fi->i_compress_algorithm = ri->i_compress_algorithm;
>>                          fi->i_log_cluster_size = ri->i_log_cluster_size;
>>                          fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
>> +                       if (fi->i_compress_algorithm == COMPRESS_LZ4 &&
>> +                                       F2FS_OPTION(sbi).lz4hc_clevel)
>> +                               fi->i_lz4hc_clevel =
>> +                                       F2FS_OPTION(sbi).lz4hc_clevel;
>>                          fi->i_cluster_size = 1 << fi->i_log_cluster_size;
>>                          set_inode_flag(inode, FI_COMPRESSED_FILE);
>>                  }
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b0c6ef2df7b8..2cd7fcc400b8 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/quota.h>
>>   #include <linux/unicode.h>
>>   #include <linux/part_stat.h>
>> +#include <linux/lz4.h>
>>
>>   #include "f2fs.h"
>>   #include "node.h"
>> @@ -148,6 +149,7 @@ enum {
>>          Opt_compress_extension,
>>          Opt_compress_chksum,
>>          Opt_compress_cache,
>> +       Opt_compress_lz4hc_clevel,
>>          Opt_atgc,
>>          Opt_err,
>>   };
>> @@ -218,6 +220,7 @@ static match_table_t f2fs_tokens = {
>>          {Opt_compress_extension, "compress_extension=%s"},
>>          {Opt_compress_chksum, "compress_chksum"},
>>          {Opt_compress_cache, "compress_cache"},
>> +       {Opt_compress_lz4hc_clevel, "compress_lz4hc_clevel=%u"},
>>          {Opt_atgc, "atgc"},
>>          {Opt_err, NULL},
>>   };
>> @@ -944,12 +947,20 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>                  case Opt_compress_cache:
>>                          set_opt(sbi, COMPRESS_CACHE);
>>                          break;
>> +               case Opt_compress_lz4hc_clevel:
>> +                       if (args->from && match_int(args, &arg))
>> +                               return -EINVAL;
>> +                       if (arg < LZ4HC_MIN_CLEVEL || arg > LZ4HC_MAX_CLEVEL)
>> +                               return -EINVAL;
>> +                       F2FS_OPTION(sbi).lz4hc_clevel = arg;
>> +                       break;
>>   #else
>>                  case Opt_compress_algorithm:
>>                  case Opt_compress_log_size:
>>                  case Opt_compress_extension:
>>                  case Opt_compress_chksum:
>>                  case Opt_compress_cache:
>> +               case Opt_compress_lz4hc_clevel:
>>                          f2fs_info(sbi, "compression options not supported");
>>                          break;
>>   #endif
>> @@ -1543,6 +1554,10 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
>>
>>          if (test_opt(sbi, COMPRESS_CACHE))
>>                  seq_puts(seq, ",compress_cache");
>> +
>> +       if (F2FS_OPTION(sbi).lz4hc_clevel)
>> +               seq_printf(seq, ",compress_lz4hc_clevel=%u",
>> +                               F2FS_OPTION(sbi).lz4hc_clevel);
>>   }
>>
>>   static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>> --
>> 2.26.2
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
