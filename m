From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 1/4] f2fs: Lower threshold for disable_cp_again
Date: Mon, 3 Jun 2019 18:33:30 +0800
Message-ID: <1246dcc9-800a-ef0e-7cd0-199a0a6d77d4@huawei.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-2-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530004906.261170-2-drosen@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/30 8:49, Daniel Rosenberg wrote:
> The existing threshold for allowable holes at checkpoint=disable time is
> too high. The OVP space contains reserved segments, which are always in
> the form of free segments. These must be subtracted from the OVP value.
> 
> The current threshold is meant to be the maximum value of holes of a
> single type we can have and still guarantee that we can fill the disk
> without failing to find space for a block of a given type.
> 
> If the disk is full, ignoring current reserved, which only helps us,
> the amount of unused blocks is equal to the OVP area. Of that, there
> are reserved segments, which must be free segments, and the rest of the
> ovp area, which can come from either free segments or holes. The maximum
> possible amount of holes is OVP-reserved.
> 
> Now, consider the disk when mounting with checkpoint=disable.
> We must be able to fill all available free space with either data or
> node blocks. When we start with checkpoint=disable, holes are locked to
> their current type. Say we have H of one type of hole, and H+X of the
> other. We can fill H of that space with arbitrary typed blocks via SSR.
> For the remaining H+X blocks, we may not have any of a given block type
> left at all. For instance, if we were to fill the disk entirely with
> blocks of the type with fewer holes, the H+X blocks of the opposite type
> would not be used. If H+X > OVP-reserved, there would be more holes than
> could possibly exist, and we would have failed to find a suitable block
> earlier on, leading to a crash in update_sit_entry.
> 
> If H+X <= OVP-reserved, then the holes end up effectively masked by the OVP
> region in this case.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
