From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] libf2fs: read "disk model" from SCSI
 ioctl the same way kernel does
Date: Mon, 28 May 2018 15:20:40 +0800
Message-ID: <0f7b29ff-83c3-c817-ca84-87ebbf32f483@huawei.com>
References: <20180506225014.28201-1-kilobyte@angband.pl>
 <20180507215811.GA90393@jaegeuk-macbookpro.roam.corp.google.com>
 <20180524211700.r2r2hybkzwhxs3du@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fNCSm-0007zI-0Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 07:21:04 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fNCSk-0070oN-DC
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 07:21:03 +0000
In-Reply-To: <20180524211700.r2r2hybkzwhxs3du@angband.pl>
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
To: Adam Borowski <kilobyte@angband.pl>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/5/25 5:17, Adam Borowski wrote:
> On Mon, May 07, 2018 at 02:58:11PM -0700, Jaegeuk Kim wrote:
>> On 05/07, Adam Borowski wrote:
>>> One offender I own has:
>>> STORAGE DEVICE  1404x05xe3x07QGENEx00%x00x00x00x00x00x00x00x00x00x00x00x00x170x04
>>>
>>> I limited it to pure ASCII only, but you might want to allow high-bit bytes,
>>> either validating UTF-8 or assuming that mojibake is not as bad as beep and
>>> zeroes as in the above example.  Or, cutting off at the first control
>>> character might be a good alternative too.
>>
>> How about printing only valid characters here? In my virtualbox, this is
>> showing garbage characters.
> 
> I dug more, and it turns out that both the old way and what I had proposed
> are totally wrong.  This field is not a real (ie, zero-terminated) string,
> and its length is 16 bytes rather than 64 as in current code.  I went
> through all SD card readers and USB sticks I had at hand, and indeed the
> value is always padded with spaces.  Stuff past byte 16 might be zeroes,
> spaces or garbage -- for real (SATA) disks it's clean, for USB stuff it
> tends to be junk.  There's a four-byte "rev" field that's sometimes
> interesting, but even if we want to print it, it would require a separator.
> 
> So, here's another stab:
> 
> -- >8 --
> Subject: libf2fs: read "disk model" from SCSI ioctl the same way kernel does
> 
> Ref: drivers/scsi/scsi_scan.c scsi_add_lun()
> 
> Ie, fixed-width 16 bytes, assumed to be filled with spaces -- NOT
> null-terminated; comments suggest that in some cases this field can be
> truncated and filled with nulls but printf is fine with that.
> 
> The old code did read up to 64 characters, which produced garbage for
> at least some USB-attached card readers.  It also special-cased '`'
> character which the kernel does not.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
