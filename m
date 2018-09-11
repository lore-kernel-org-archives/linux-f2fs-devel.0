From: Chao Yu <yuchao0@huawei.com>
Subject: Re: f2fs page flag set with private but page.private
 pointer is NULL
Date: Tue, 11 Sep 2018 18:21:28 +0800
Message-ID: <c378cd65-f5c3-32aa-9f77-6e5f462e4495@huawei.com>
References: <CAKwPUoy9QQfbsi7P+_-zyX_dg=mw-gmvSWgLGDDYoVcmh-_=nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fzfne-0003Zi-Vh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 10:21:38 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzfnc-008KD5-SB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 10:21:38 +0000
In-Reply-To: <CAKwPUoy9QQfbsi7P+_-zyX_dg=mw-gmvSWgLGDDYoVcmh-_=nw@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kassey <kassey1216@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net

Hi Kassey,

I sent a patch to solve potential deadlock, but not sure it can fix your
problem, could you try that patch?

[PATCH] f2fs: submit cached bio to avoid endless PageWriteback

On 2018/9/11 11:03, Kassey wrote:
> hi, Jaegeuk:
> 
>    we got some easy reproduced issue when doing reboot test.
>    that the android init is sleep on a page to be writebback.
>    from the ftrace we can confirm wb_workfn got running each 5s.
>    but init has stuck for quite long time because below page can not
> be writeback done.
> 
>    by check the page's member(a_ops) , we can see that is  f2fs page
> and private is NULL.
> 
>    can you help to give some suggest  ?
> 
> 
>    crash> kmem 0xFFFFFFBF01B6C840
> 
>       PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
> 
> ffffffbf01b6c840         6db21000 ffffffc0964d1bc0       5c  2 1292c
> referenced,uptodate,lru,owner_priv_1,private,writeback,mappedtodisk
> 
> crash> struct page  0xFFFFFFBF01B6C840
> struct page {
>   flags = 76076,
>   {
>     mapping = 0xffffffc0964d1bc0,
>     s_mem = 0xffffffc0964d1bc0,
>     compound_mapcount = {
>       counter = -1773331520
>     }
>   },
>   {
>     index = 92,
>     freelist = 0x5c
>   },
>   {
>     counters = 12884901887,
>     {
>       {
>         _mapcount = {
>           counter = -1
>         },
>         active = 4294967295,
>         {
>           inuse = 65535,
>           objects = 32767,
>           frozen = 1
>         },
>         units = -1
>       },
>       _refcount = {
>         counter = 2
>       }
>     }
>   },
>   {
>     lru = {
>       next = 0xffffffbf02bd9520,
>       prev = 0xffffffbf01b66960
>     },
>     pgmap = 0xffffffbf02bd9520,
>     {
>       next = 0xffffffbf02bd9520,
>       pages = 28731744,
>       pobjects = -65
>     },
>     callback_head = {
>       next = 0xffffffbf02bd9520,
>       func = 0xffffffbf01b66960
>     },
>     {
>       compound_head = 18446743794582656288,
>       compound_dtor = 28731744,
>       compound_order = 4294967231
>     }
>   },
>   {
>     private = 0,
>     ptl = 0x0,
>     slab_cache = 0x0
>   }
> }
> 
> 
> init:
> 
> 
> -000|__switch_to()
> 
> -001|__schedule()
> 
> -002|need_resched(inline)
> 
> -002|schedule()
> 
> -003|schedule_timeout()
> 
> -004|get_current(inline)
> 
> -004|io_schedule_timeout()
> 
> -005|bit_wait_io()
> 
> -006|__wait_on_bit()
> 
> -007|wait_on_page_bit()
> 
> -008|PageWriteback(inline)
> 
> -008|wait_on_page_writeback(inline)
> 
> -008|__filemap_fdatawait_range()
> 
> -009|filemap_fdatawait_keep_errors()
> 
> -010|sync_inodes_sb()
> 
> -011|__sync_filesystem(inline)
> 
> -011|sync_filesystem()
> 
> -012|generic_shutdown_super()
> 
> -013|kill_block_super()
> 
> -014|kill_f2fs_super()
> 
> -015|deactivate_locked_super()
> 
> -016|deactivate_super()
> 
> -017|mnt_free_id(inline)
> 
> -017|cleanup_mnt()
> 
> -018|__cleanup_mnt()
> 
> -019|task_work_run()
> 
> -020|do_notify_resume()
> 
> -021|work_pending(asm)
> 
> -->|exception
> 
> -022|NUX:0x539E58(asm)
> 
> ---|end of frame
> 
> 
