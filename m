From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type
 of segments
Date: Thu, 9 Nov 2017 17:12:57 +0800
Message-ID: <1b0b44de-c724-5dc4-e9cb-79a894bdb611@huawei.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eCith-0003YR-Af
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 09:13:17 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eCitf-0002IP-02
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Nov 2017 09:13:17 +0000
In-Reply-To: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
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
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/9 13:51, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> Using write hints[1], applications can inform the life time of the data
> written to devices. and this[2] reported that the write hints patch
> decreased writes in NAND by 25%.
> 
> This hints help F2FS to determine the followings.
>   1) the segment types where the data will be written.
>   2) the hints that will be passed down to devices with the data of segments.
> 
> This patch set implements the first mapping from write hints to segment types
> as shown below.
> 
>   hints                     segment type
>   -----                     ------------
>   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
>   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
>   others                    CURSEG_WARM_DATA
> 
> The F2FS poliy for hot/cold seperation has precedence over this hints, And
> hints are not applied in in-place update.

Could we change to disable IPU if file/inode write hint is existing?

> 
> Before the second mapping is implemented, write hints are not passed down
> to devices. Because it is better that the data of a segment have the same 
> hint.
> 
> [1]: c75b1d9421f80f4143e389d2d50ddfc8a28c8c35
> [2]: https://lwn.net/Articles/726477/

Could you write a patch to support passing write hint to block layer for
buffered writes as below commit:
0127251c45ae ("ext4: add support for passing in write hints for buffered writes")

Thanks,

> 
> Hyunchul Lee (2):
>   f2fs: apply write hints to select the type of segments for buffered
>     write
>   f2fs: apply write hints to select the type of segment for direct write
> 
>  fs/f2fs/data.c    | 101 ++++++++++++++++++++++++++++++++----------------------
>  fs/f2fs/f2fs.h    |   1 +
>  fs/f2fs/segment.c |  14 +++++++-
>  3 files changed, 74 insertions(+), 42 deletions(-)
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
